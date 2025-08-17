#!/bin/bash
echo "================================================"
echo "ステップ5: LoRAアダプター付きGemma-3-270m-itをテスト中"
echo "================================================"

source venv/bin/activate

MODEL="lmstudio-community/gemma-3-270m-it-MLX-8bit"
ADAPTER_PATH="./gemma_3_lora_adapter"

echo "アダプターなしのベースモデルをテスト中..."
python inference.py --base-model $MODEL --prompt "What is TechNavi?"

echo ""
echo "LoRAアダプター付きモデルをテスト中..."
python inference.py --base-model $MODEL --adapter-path $ADAPTER_PATH --prompt "What is TechNavi?"

echo ""
echo "テスト完了！上記の応答を比較してください。"