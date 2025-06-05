# 動画機能強化 実装計画書

## 概要

現在のグレープサポートアプリの動画機能に以下の2つの機能を追加します：

1. **ローカル動画保存・再生機能** - ネットワーク負荷軽減とオフライン再生対応
2. **動画再生シークバー改善** - ユーザビリティ向上（既存実装の調整）

## 現状分析

### 既存の動画実装

- **撮影**: `TakeVideoScreen` でカメラ撮影 → Firebase Storage直接アップロード
- **再生**: `WatchVideoScreen` で Firebase Storage URL から直接ストリーミング再生  
- **プログレスバー**: `AppVideoProgressIndicator` で実装済み（`allowScrubbing: true`）
- **シーク機能**: `VideoScrubber` で既に実装済み

### 課題

1. 毎回ネットワークから動画読み込みでデータ使用量が多い
2. オフライン時に動画再生不可
3. シーク機能が実装済みだがユーザーが認識しにくい可能性

## 実装計画

### Phase 1: ローカル動画保存・再生機能

#### 1.1 依存関係の追加

```yaml
# pubspec.yaml に追加
dependencies:
  dio: ^5.3.2  # ダウンロード進捗表示用
  crypto: ^3.0.3  # ファイルハッシュ生成用
```

#### 1.2 新規作成ファイル

**`lib/services/video_cache_service.dart`**

```dart
@riverpod
class VideoCacheService extends _$VideoCacheService {
  // ローカル動画キャッシュ管理
  // - ダウンロード状況管理
  // - ローカルファイルパス管理  
  // - 自動キャッシュクリーンアップ
}
```

**`lib/models/video_cache_model.dart`**

```dart
@freezed
class VideoCacheModel with _$VideoCacheModel {
  const factory VideoCacheModel({
    required String grapeId,
    required String remoteUrl,
    String? localPath,
    required CacheStatus status,
    double? downloadProgress,
    DateTime? lastAccessed,
  }) = _VideoCacheModel;
}

enum CacheStatus { notCached, downloading, cached, error }
```

#### 1.3 修正対象ファイル

**`lib/features/video/pages/watch_video/view_model.dart`**
- `_initializeVideo` メソッドを修正
- ローカルキャッシュ確認ロジック追加
- 未キャッシュ時の自動ダウンロード機能

**`lib/features/video/pages/take_video/view.dart`**  
- 撮影完了時にローカル保存も実行
- Firebase Storage アップロード後、ローカルキャッシュにも保存

#### 1.4 実装手順

1. `VideoCacheService` 作成 - ダウンロード・キャッシュ管理
2. `VideoViewModel` 修正 - キャッシュ優先の動画読み込み
3. `TakeVideoScreen` 修正 - 撮影動画のローカル保存
4. キャッシュクリーンアップ機能（容量制限・期限管理）

### Phase 2: シークバー機能改善

#### 2.1 現状確認

- `AppVideoProgressIndicator` で `allowScrubbing: true` 設定済み
- `VideoScrubber` でタップ・ドラッグによるシーク機能実装済み

#### 2.2 改善内容

**`lib/features/video/components/app_video_progress_indicator.dart`**
- 視覚的フィードバック強化
- シーク操作時の時間表示追加
- プログレスバーの高さ・色調整

**`lib/features/video/components/video_controls.dart`** (新規)

```dart
class VideoControls extends ConsumerWidget {
  // 再生/一時停止ボタン
  // 時間表示（現在時間/総時間）
  // 音量調整
  // フルスクリーンボタン
}
```

#### 2.3 実装手順

1. 現在の `AppVideoProgressIndicator` の動作確認
2. シーク操作時の視覚的フィードバック追加
3. 時間表示UI追加
4. 操作性テスト・調整

### Phase 3: 統合・テスト

#### 3.1 ユーザビリティ改善

- ダウンロード進捗表示
- オフライン表示
- エラーハンドリング強化

#### 3.2 音声フィードバック追加

CLAUDE.md の指針に従い、以下のタイミングで音声フィードバック：
- 動画ダウンロード完了時
- 動画撮影完了時
- エラー発生時

#### 3.3 テスト項目

- [ ] ローカルキャッシュ動作テスト
- [ ] オフライン再生テスト  
- [ ] シーク操作テスト
- [ ] 容量制限テスト
- [ ] エラーケーステスト

## 技術的考慮事項

### ストレージ管理

- アプリケーションディレクトリ内に動画保存
- 容量制限（例：500MB）設定
- LRU（最近最小使用）でキャッシュクリーンアップ

### パフォーマンス最適化

- バックグラウンドダウンロード
- ダウンロード進捗の適切な更新頻度
- メモリリークの防止

### セキュリティ

- ローカルファイルの暗号化（必要に応じて）
- 不正アクセス防止

## 開発スケジュール目安

| フェーズ | 内容 | 期間 |
|---------|------|------|
| **Phase 1** | ローカル保存・再生機能 | 4-5日 |
| **Phase 2** | シークバー改善 | 1-2日 |
| **Phase 3** | 統合・テスト | 1-2日 |
| **合計** | | **約1週間** |

## 成果物

1. ✅ ローカルキャッシュされた動画のオフライン再生
2. ✅ ネットワーク使用量の大幅削減
3. ✅ 改善されたシーク操作ユーザビリティ
4. ✅ 音声フィードバックによる操作確認

## 実装チェックリスト

### Phase 1: ローカル動画保存・再生機能

- [ ] `pubspec.yaml` に `dio` と `crypto` の依存関係追加
- [ ] `VideoCacheModel` 作成（Freezed使用）
- [ ] `VideoCacheService` 作成（Riverpod使用）
- [ ] `VideoViewModel` にキャッシュロジック追加
- [ ] `TakeVideoScreen` にローカル保存機能追加
- [ ] キャッシュクリーンアップ機能実装
- [ ] エラーハンドリング追加

### Phase 2: シークバー機能改善

- [ ] 現在の `AppVideoProgressIndicator` 動作確認
- [ ] 視覚的フィードバック強化
- [ ] 時間表示UI追加
- [ ] `VideoControls` コンポーネント作成
- [ ] `VideoPlayerWidget` に新しいコントロール統合

### Phase 3: 統合・テスト

- [ ] ダウンロード進捗表示UI
- [ ] オフライン状態の表示
- [ ] 音声フィードバック実装
- [ ] 全体的なエラーハンドリング強化
- [ ] テストケース実行
- [ ] パフォーマンステスト
- [ ] ユーザビリティテスト

## 注意事項

- 既存のシーク機能は実装済みのため、UI/UX改善に焦点を当てる
- Firebase Storage との整合性を保つ
- アプリの容量増加に注意（キャッシュサイズ制限）
- iOS/Android両方での動作確認必須
- ネットワーク状態の変化に対する適切な処理