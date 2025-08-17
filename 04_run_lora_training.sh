#!/bin/bash
echo "================================================"
echo "ステップ4: Gemma-3-270m-it-MLX-8bitでLoRAファインチューニングを実行中"
echo "================================================"

source venv/bin/activate

MODEL="lmstudio-community/gemma-3-270m-it-MLX-8bit"
ADAPTER_PATH="./gemma_3_lora_adapter"

echo "モデル: $MODEL"
echo "アダプターは以下に保存されます: $ADAPTER_PATH"
echo ""
echo "Gemma-3用に最適化されたパラメータでLoRAトレーニングを開始中..."
echo "- バッチサイズ: 1 (勾配蓄積付き)"
echo "- 学習率: 1e-4 (小さいモデル用の保守的設定)"
echo "- トレーニング回数: 200 (270Mモデルに適した回数)"
echo "- LoRA層数: 8 (小さいモデル用のバランス設定)"
echo "- 最大シーケンス長: 512 (Gemma-3に最適化)"
echo "- レポート間隔: 10ステップ"
echo ""

python -m mlx_lm lora \
  --model $MODEL \
  --train \
  --data ./data \
  --batch-size 1 \
  --iters 200 \
  --val-batches 10 \
  --learning-rate 1e-4 \
  --save-every 50 \
  --adapter-path $ADAPTER_PATH \
  --max-seq-length 512 \
  --num-layers 8 \
  --steps-per-report 10 \
  --steps-per-eval 50 \
  --seed 42

echo ""
echo "================================================"
echo "トレーニング完了！"
echo "================================================"
echo ""
echo "📁 ファインチューニングされたモデルの保存場所:"
echo "   $ADAPTER_PATH"
echo ""
echo "📊 ファイルサイズ:"
if [ -d "$ADAPTER_PATH" ]; then
    du -sh "$ADAPTER_PATH"
    echo ""
    echo "📋 含まれるファイル:"
    ls -la "$ADAPTER_PATH"
else
    echo "❌ アダプターディレクトリが見つかりません"
fi
echo ""
echo "🚀 使用方法:"
echo "   python inference.py --adapter-path $ADAPTER_PATH --prompt \"What is TechNavi?\""
echo ""
echo "✅ ファインチューニング完了！"