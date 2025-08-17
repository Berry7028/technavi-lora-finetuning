#!/bin/bash
echo "================================================"
echo "ステップ1: Python環境をセットアップ中"
echo "================================================"

# Python 3.9+が必要
python3 --version

# 仮想環境を作成
echo "仮想環境を作成中..."
python3 -m venv venv

# 仮想環境をアクティベート
echo "仮想環境をアクティベート中..."
source venv/bin/activate

echo "環境セットアップ完了！"
echo "仮想環境をアクティベートするには: source venv/bin/activate"