# モデル情報

## 現在のモデル: Gemma-3-270m-it-MLX-8bit

### モデル詳細
- **名前**: `lmstudio-community/gemma-3-270m-it-MLX-8bit`
- **サイズ**: 270Mパラメータ
- **タイプ**: 指示調整済み言語モデル
- **量子化**: 8-bit
- **フレームワーク**: MLX (Apple Silicon最適化)
- **ライセンス**: Gemmaライセンス (Google)

### なぜGemma-3-270m-itなのか？
- **効率性**: 小さいモデルサイズにより高速なトレーニングと推論が可能
- **品質**: タスク性能向上のための指示調整済み
- **Apple Silicon**: MLXフレームワークに最適化
- **アクセシビリティ**: コンシューマーMacハードウェアで良好に動作

### トレーニング設定
- **手法**: LoRA (Low-Rank Adaptation)
- **学習率**: 1e-4
- **バッチサイズ**: 1 (勾配蓄積付き)
- **最大シーケンス長**: 512トークン
- **LoRA層数**: 8
- **トレーニング回数**: 200

### 性能期待値
- **トレーニング時間**: M1/M2/M3 Macで10-30分
- **メモリ使用量**: トレーニング中に約2-4GB
- **推論速度**: Apple Siliconで高速
- **モデルサイズ**: 約100MB LoRAアダプター

### プロンプトフォーマット
Gemma-3は特定のプロンプトフォーマットを使用:
```
<start_of_turn>user
{user_message}<end_of_turn>
<start_of_turn>model
{model_response}
```

### 使用例
- **TechNavi知識**: TechNavi YouTubeチャンネルに関する専門的な応答
- **ML/AIチュートリアル**: 技術的な説明とガイダンス
- **Apple Silicon**: MLXとMetal最適化のアドバイス
- **ローカルAI**: プライバシー重視のAIアプリケーション

## 代替モデル

### より大きなモデル用
- `lmstudio-community/gpt-oss-20b-MLX-8bit` (20Bパラメータ)
- `lmstudio-community/llama-3.1-8b-instruct-MLX-8bit` (8Bパラメータ)

### より小さなモデル用
- `lmstudio-community/phi-3-mini-4k-instruct-MLX-8bit` (3.8Bパラメータ)
- `lmstudio-community/qwen2.5-1.5b-instruct-MLX-8bit` (1.5Bパラメータ)

## モデル選択ガイド

### Gemma-3-270m-itを選択する場合:
- 高速なトレーニングと推論が必要
- 限られたハードウェアリソースで作業
- 迅速な実験が必要
- 特定のドメイン知識に焦点

### より大きなモデルを選択する場合:
- より高品質な応答が必要
- 強力なハードウェア (M3 Max/Ultra) を持っている
- 複雑な推論タスクに取り組んでいる
- より長いトレーニング時間を許容できる