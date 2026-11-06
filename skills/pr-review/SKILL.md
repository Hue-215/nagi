---
name: pr-review
description: PR作成前のレビュー手順。PR作成前に必ず使用する。
---

# PR作成前のレビュー手順
PR作成前に、以下の手順に従いレビューを行う。

## 1. `/pr-review-toolkit:review-pr`
`/pr-review-toolkit:review-pr <ベースブランチ>...HEAD code tests errors comments types`でレビューを行う。範囲を指定しないと、commitしていない変更しか見ない。

指摘を直したあと、`simplify`を指定してもう一度呼ぶ。

手順2に進む前に、変更をcommitし、claude-securityに見えるようにする。

## 2. `/claude-security scan changes`
セキュリティに関わる内容(外部通信、秘密情報の取り扱い、権限の設定、実行時依存の追加など)を行った場合は、claude-securityを用いてレビューを行う。予算の都合からeffortはlowとし、claude自身は実行できないためユーザーに`/claude-security scan changes --effort low`を実行させる。
