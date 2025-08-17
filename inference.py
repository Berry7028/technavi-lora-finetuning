#!/usr/bin/env python3
import mlx.core as mx
from mlx_lm import load, generate
import argparse
import json

def load_model_with_lora(base_model_path, adapter_path=None):
    print(f"ベースモデルを読み込み中: {base_model_path}")
    if adapter_path:
        model, tokenizer = load(base_model_path, adapter_path=adapter_path)
        print(f"LoRAアダプター付きモデルを読み込みました: {adapter_path}")
    else:
        model, tokenizer = load(base_model_path)
        print(f"アダプターなしのベースモデルを読み込みました")
    return model, tokenizer

def generate_response(model, tokenizer, prompt, max_tokens=200, verbose=False, show_reasoning=True):
    # Gemma-3は異なるプロンプトフォーマットを使用
    formatted_prompt = f"<start_of_turn>user\n{prompt}<end_of_turn>\n<start_of_turn>model\n"
    
    print(f"\n{'='*60}")
    print(f"プロンプト: {prompt}")
    print(f"{'='*60}")
    
    if verbose:
        print("\n[トークン生成 - 詳細モード]")
        print("トークンごとに応答を生成中...\n")
    
    response = generate(
        model, 
        tokenizer, 
        prompt=formatted_prompt,
        max_tokens=max_tokens,
        verbose=verbose
    )
    
    # Gemma-3フォーマットからモデルの応答を抽出
    if "<start_of_turn>model\n" in response:
        assistant_response = response.split("<start_of_turn>model\n")[-1].strip()
    else:
        assistant_response = response.strip()
    
    # 推論が含まれている場合は解析
    if show_reasoning and "<thinking>" in assistant_response:
        parts = assistant_response.split("</thinking>")
        if len(parts) >= 2:
            reasoning = parts[0].replace("<thinking>", "").strip()
            actual_response = parts[1].strip()
            
            print(f"\n[推論/思考プロセス]")
            print(f"{reasoning}")
            print(f"\n[応答]")
            print(f"{actual_response}")
        else:
            print(f"\n[応答]")
            print(f"{assistant_response}")
    else:
        if not verbose:
            print(f"応答: {assistant_response}")
        else:
            print(f"\n[最終応答]")
            print(f"{assistant_response}")
    
    print(f"{'='*60}\n")
    
    return assistant_response

def test_technavi_prompts(model, tokenizer):
    test_prompts = [
        "How do I set up MLX for machine learning on my Mac?",
        "What's the best way to optimize LoRA training?",
        "Can you explain gradient accumulation?",
        "How can I monitor GPU usage on Mac?",
        "What causes NaN losses in training?",
        "How do I save and load LoRA adapters?",
        "What's the difference between LoRA and QLoRA?",
        "How can I reduce memory usage during fine-tuning?"
    ]
    
    print("\n" + "="*60)
    print("TechNaviスタイルのプロンプトでファインチューニングされたモデルをテスト中")
    print("="*60)
    
    for i, prompt in enumerate(test_prompts, 1):
        print(f"\nテスト {i}/{len(test_prompts)}:")
        generate_response(model, tokenizer, prompt, max_tokens=150, verbose=False)

def interactive_mode(model, tokenizer, verbose=False, show_reasoning=True):
    print("\n" + "="*60)
    print("インタラクティブモード - 'quit'と入力して終了")
    if verbose:
        print("詳細モード有効 - トークン生成を表示")
    if show_reasoning:
        print("推論モード有効 - 思考プロセスを表示")
    print("="*60)
    
    while True:
        prompt = input("\nプロンプトを入力してください: ")
        if prompt.lower() in ['quit', 'exit', 'q']:
            print("さようなら！")
            break
        
        generate_response(model, tokenizer, prompt, max_tokens=200, verbose=verbose, show_reasoning=show_reasoning)

def main():
    parser = argparse.ArgumentParser(description="LoRAアダプター付きGemma-3-270m-itをテスト")
    parser.add_argument("--base-model", type=str, 
                      default="lmstudio-community/gemma-3-270m-it-MLX-8bit",
                      help="ベースモデルパス")
    parser.add_argument("--adapter-path", type=str,
                      default=None,
                      help="LoRAアダプターパス (オプション)")
    parser.add_argument("--interactive", action="store_true",
                      help="インタラクティブモードで実行")
    parser.add_argument("--test-all", action="store_true",
                      help="すべてのTechNaviプロンプトでテスト")
    parser.add_argument("--prompt", type=str,
                      help="テストする単一のプロンプト")
    parser.add_argument("--max-tokens", type=int, default=200,
                      help="生成する最大トークン数")
    parser.add_argument("--verbose", "-v", action="store_true",
                      help="トークンごとの生成を表示 (詳細モード)")
    parser.add_argument("--no-reasoning", action="store_true",
                      help="推論/思考プロセスの表示を無効化")
    
    args = parser.parse_args()
    show_reasoning = not args.no_reasoning
    
    model, tokenizer = load_model_with_lora(args.base_model, args.adapter_path)
    
    if args.interactive:
        interactive_mode(model, tokenizer, verbose=args.verbose, show_reasoning=show_reasoning)
    elif args.test_all:
        test_technavi_prompts(model, tokenizer)
    elif args.prompt:
        generate_response(model, tokenizer, args.prompt, 
                        args.max_tokens, verbose=args.verbose, show_reasoning=show_reasoning)
    else:
        print("サンプルプロンプトでテスト中...")
        generate_response(model, tokenizer, 
                        "What is TechNavi?",
                        args.max_tokens, verbose=args.verbose, show_reasoning=show_reasoning)

if __name__ == "__main__":
    main()