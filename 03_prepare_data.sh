#!/bin/bash
echo "================================================"
echo "ステップ3: トレーニングデータを準備中"
echo "================================================"

echo "データディレクトリを確認中..."
if [ -d "data" ]; then
    echo "✅ データディレクトリが存在します"
    echo "✅ train.jsonl: $(wc -l < data/train.jsonl) 行"
    echo "✅ valid.jsonl: $(wc -l < data/valid.jsonl) 行"
else
    echo "❌ データディレクトリが見つかりません"
    exit 1
fi

echo ""
echo "データ準備完了！"
echo "TechNavi YouTubeチャンネルに関する52のトレーニング例が利用可能です。"