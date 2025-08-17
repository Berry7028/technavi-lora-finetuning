#!/bin/bash

echo "================================================"
echo "TechNavi LoRA ファインチューニング デモ"
echo "モデル: Gemma-3-270m-it-MLX-8bit"
echo "================================================"

# 正しいディレクトリにいるかチェック
if [ ! -f "01_setup_environment.sh" ]; then
    echo "エラー: プロジェクトのルートディレクトリから実行してください"
    exit 1
fi

# ステップ1: 環境セットアップ
echo ""
echo "ステップ1: Python環境をセットアップ中..."
./01_setup_environment.sh

if [ $? -ne 0 ]; then
    echo "エラー: 環境セットアップに失敗しました"
    exit 1
fi

# 仮想環境をアクティベート
source venv/bin/activate

# ステップ2: MLXのインストール
echo ""
echo "ステップ2: MLXをインストール中..."
./02_install_mlx.sh

if [ $? -ne 0 ]; then
    echo "エラー: MLXのインストールに失敗しました"
    exit 1
fi

# ステップ3: データの準備
echo ""
echo "ステップ3: トレーニングデータを準備中..."
./03_prepare_data.sh

if [ $? -ne 0 ]; then
    echo "エラー: データの準備に失敗しました"
    exit 1
fi

# ステップ4: LoRAトレーニングの実行
echo ""
echo "ステップ4: LoRAファインチューニングを開始中..."
echo "Macの性能によって10-30分かかる場合があります..."
./04_run_lora_training.sh

if [ $? -ne 0 ]; then
    echo "エラー: LoRAトレーニングに失敗しました"
    exit 1
fi

# ステップ5: モデルのテスト
echo ""
echo "ステップ5: ファインチューニングされたモデルをテスト中..."
./05_test_inference.sh

if [ $? -ne 0 ]; then
    echo "エラー: モデルのテストに失敗しました"
    exit 1
fi

# ステップ6: ベースモデルとLoRAの比較
echo ""
echo "ステップ6: ベースモデルとファインチューニングモデルを比較中..."
./08_compare_lora_inference.sh

echo ""
echo "================================================"
echo "デモ完了！"
echo "================================================"
echo ""
echo "達成したこと:"
echo "✅ Apple Silicon用のMLX環境をセットアップ"
echo "✅ TechNaviの知識でGemma-3-270m-itをファインチューニング"
echo "✅ モデルの応答をテスト"
echo "✅ ベースモデルとファインチューニングモデルの性能を比較"
echo ""
echo "📁 ファインチューニングされたモデルの保存場所:"
echo "   ./gemma_3_lora_adapter/"
echo ""
echo "📊 モデル情報:"
if [ -d "./gemma_3_lora_adapter" ]; then
    echo "   サイズ: $(du -sh ./gemma_3_lora_adapter | cut -f1)"
    echo "   ファイル数: $(find ./gemma_3_lora_adapter -type f | wc -l)"
else
    echo "   ❌ アダプターディレクトリが見つかりません"
fi
echo ""
echo "次のステップ:"
echo "- インタラクティブモードを試す: python inference.py --interactive"
echo "- 独自のプロンプトでテスト: python inference.py --adapter-path ./gemma_3_lora_adapter --prompt \"あなたの質問\""
echo "- 異なるトレーニングパラメータで実験"
echo ""
echo "楽しいコーディングを！ 🚀"