---
name: setup
description: このリポジトリのプラグイン(nagi)と、それが前提とするプラグイン・claude.aiのスキル・設定を端末にそろえる。新しい端末で使い始めるとき、環境を作り直したときに開く。
---

# 端末の初期設定

済んでいる項目は飛ばし、最後に何をしたかを報告する。

## 1. プラグイン

次のプラグインが`claude plugin list`に`<名前>@synced`として出て、読み込まれているかを確かめる。
出ていなければ、claude.aiのCustomize > Pluginsで有効にするようユーザーに頼む。
端末への同期は起動したあとに裏で走るので、`Plugins changed`と出てから、起動し直してもらう。

| 名前 | claude.aiでの入れ方 | 用途 |
|---|---|---|
| `nagi` | Add > Add marketplaceで`Hue-215/nagi`を追加し、Sync automaticallyをオンにする | 共通の指示と、開発作業のスキル・エージェント |
| `pr-review-toolkit` | Discoverから入れる | `featdev`・`pr-review`でのレビュー |
| `claude-security` | Discoverから入れる | セキュリティに関わるPRの差分スキャン(`pr-review`) |
| `security-guidance` | Discoverから入れる | 編集・コミット時のセキュリティの警告とレビュー(フック。Python 3が要る) |

`<名前>@synced`が`not loaded`と出ていたら、同じ名前のプラグインを`claude plugin install`でも入れているので、
そちらをアンインストールする(以前のsetupの手順で入れたもの)。

## 2. 以前の設定の削除

プラグインにする前の設定が残っていれば消す。

- `~/.claude/CLAUDE.md`の`@~/Documents/dotclaude/CLAUDE.md`のような行。instructions.mdはフックで読み込むので、書き換えずに消す。ほかの行は残す
- `~/.claude/skills/`と`~/.claude/agents/`にある、このリポジトリの`skills/`・`agents/`と同じ名前のディレクトリ・ファイル。
  残すとスキルとエージェントが2つずつ入る。Windowsのジャンクションとハードリンクのほか、リンクが切れてコピーになったものも含む。
  リンクとジャンクションは、名前の末尾に`/`を付けずに`rm`する(付けるとリンク先の中身を消す)

## 3. claude.aiのスキル

`anthropic-skills:doc-coauthoring`(文書を共同で書く手順)が使えるスキルの一覧に無ければ、
claude.aiの設定のスキルから有効にするよう、ユーザーに頼む。

## 4. 設定

`~/.claude/settings.json`の`env`に次を足す。ほかのキーは変えない。

- `ENABLE_STOP_REVIEW=0`: security-guidanceの、ターンを終えるたびの差分レビューを止める
  (コミット・push時のレビューは残る)。並行して動かす別のセッションがHEADを動かすと誤作動するため
