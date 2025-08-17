#!/bin/bash
echo "================================================"
echo "環境クリーンアップ"
echo "================================================"

echo "このスクリプトは以下を削除します:"
echo "- 仮想環境 (venv/)"
echo "- トレーニングされたアダプター"
echo "- キャッシュファイル"
echo "- 一時ファイル"
echo ""

read -p "続行しますか？ (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "クリーンアップをキャンセルしました。"
    exit 1
fi

echo ""
echo "クリーンアップを開始中..."

# 仮想環境を削除
if [ -d "venv" ]; then
    echo "仮想環境を削除中..."
    rm -rf venv
    echo "✅ 仮想環境を削除しました"
else
    echo "ℹ️  仮想環境は存在しません"
fi

# LoRAアダプターを削除
if [ -d "gemma_3_lora_adapter" ]; then
    echo "LoRAアダプターを削除中..."
    rm -rf gemma_3_lora_adapter
    echo "✅ LoRAアダプターを削除しました"
else
    echo "ℹ️  LoRAアダプターは存在しません"
fi

# 古いGPT-OSSアダプターも削除
if [ -d "gpt_oss_lora_adapter" ]; then
    echo "古いGPT-OSSアダプターを削除中..."
    rm -rf gpt_oss_lora_adapter
    echo "✅ 古いGPT-OSSアダプターを削除しました"
fi

# Pythonキャッシュを削除
echo "Pythonキャッシュを削除中..."
find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
find . -name "*.pyc" -delete 2>/dev/null || true
find . -name "*.pyo" -delete 2>/dev/null || true
echo "✅ Pythonキャッシュを削除しました"

# MLXキャッシュを削除
if [ -d "$HOME/.cache/mlx" ]; then
    echo "MLXキャッシュを削除中..."
    rm -rf "$HOME/.cache/mlx"
    echo "✅ MLXキャッシュを削除しました"
else
    echo "ℹ️  MLXキャッシュは存在しません"
fi

# 一時ファイルを削除
echo "一時ファイルを削除中..."
find . -name "*.tmp" -delete 2>/dev/null || true
find . -name "*.log" -delete 2>/dev/null || true
echo "✅ 一時ファイルを削除しました"

echo ""
echo "================================================"
echo "クリーンアップ完了！"
echo "================================================"
echo ""
echo "削除されたもの:"
echo "✅ 仮想環境"
echo "✅ LoRAアダプター"
echo "✅ Pythonキャッシュ"
echo "✅ MLXキャッシュ"
echo "✅ 一時ファイル"
echo ""
echo "再度セットアップするには:"
echo "./01_setup_environment.sh"
echo ""
echo "注意: データファイル (data/) は保持されています。"