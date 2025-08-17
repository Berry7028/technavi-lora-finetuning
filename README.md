# TechNavi LoRA ファインチューニング

Apple SiliconでLoRAを使用してTechNavi YouTubeチャンネルの知識でGemma-3-270m-itをファインチューニングします。

## クイックスタート

完全なデモを実行:
```bash
./run_full_demo.sh
```

または個別にステップを実行:
```bash
# 1. セットアップ
./01_setup_environment.sh && source venv/bin/activate

# 2. MLXのインストール
./02_install_mlx.sh

# 3. LoRAトレーニング
./04_run_lora_training.sh

# 4. モデルのテスト
python inference.py --adapter-path ./gemma_3_lora_adapter --prompt "What is TechNavi?"

# 5. ベースモデルとLoRAの比較
./08_compare_lora_inference.sh
```

## 何をするか

- **前**: TechNaviの知識がない一般的なGemma-3モデル
- **後**: TechNaviがYouTubeチャンネルであることを知り、推論能力を持つモデル

## 主な機能

- ✅ 性能統計 (トークン/秒、メモリ使用量)
- ✅ ベースモデルとLoRAの比較
- ✅ インタラクティブモード
- ✅ Gemma-3-270m-itモデルに最適化

## トレーニングデータ

推論パターンを含むTechNavi YouTubeチャンネルに関する52の例。

## モデル仕様

- **ベースモデル**: `lmstudio-community/gemma-3-270m-it-MLX-8bit`
- **モデルサイズ**: 270Mパラメータ
- **量子化**: 8-bit
- **フレームワーク**: MLX (Apple Silicon最適化)
- **トレーニング**: 効率性のためのLoRAファインチューニング
