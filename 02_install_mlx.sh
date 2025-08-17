#!/bin/bash
echo "================================================"
echo "ステップ2: MLXをインストール中"
echo "================================================"

source venv/bin/activate

echo "pipをアップグレード中..."
pip install --upgrade pip

echo "MLX-LMをインストール中..."
pip install mlx-lm

echo "MLX-LMのインストール完了！"
echo "Apple Siliconで最適化された機械学習フレームワークが利用可能になりました。"