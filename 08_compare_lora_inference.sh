#!/bin/bash
echo "================================================"
echo "ステップ8: ベースモデルとLoRA Gemma-3-270m-itを比較中"
echo "================================================"

source venv/bin/activate

MODEL="lmstudio-community/gemma-3-270m-it-MLX-8bit"
ADAPTER_PATH="./gemma_3_lora_adapter"

echo "モデル: $MODEL"
echo "アダプター: $ADAPTER_PATH"
echo ""

# テストプロンプト
PROMPTS=(
    "What is TechNavi?"
    "How do I set up MLX for machine learning on my Mac?"
    "What's the best way to optimize LoRA training?"
    "Can you explain gradient accumulation?"
    "How can I monitor GPU usage on Mac?"
)

echo "比較テストを実行中..."
echo ""

for i in "${!PROMPTS[@]}"; do
    prompt="${PROMPTS[$i]}"
    echo "テスト $((i+1))/${#PROMPTS[@]}: $prompt"
    echo "----------------------------------------"
    
    echo "ベースモデル (アダプターなし):"
    python inference.py --base-model $MODEL --prompt "$prompt" --max-tokens 100 --no-reasoning
    
    echo "ファインチューニングモデル (LoRAアダプター付き):"
    python inference.py --base-model $MODEL --adapter-path $ADAPTER_PATH --prompt "$prompt" --max-tokens 100 --no-reasoning
    
    echo ""
    echo "========================================"
    echo ""
done

echo "比較完了！"
echo ""
echo "注目すべき違い:"
echo "- ベースモデル: 一般的な応答、TechNaviを知らない可能性"
echo "- ファインチューニング: 具体的なTechNaviの知識、より詳細な応答"
echo "- 性能: 両方ともApple Siliconで高速"

