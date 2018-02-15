# Slack Mailerサンプル

本番環境以外のメール送信をフックして、slackに転送ためのActionMailer用ライブラリ

以下の記事のサンプルアプリとして作成

https://qiita.com/fursich/items/bb75a06714bcad6a0afb


（機能は`lib/`以下にまとめています）

* SlackでWebhookを設定してアドレスを取得します

* 必要に応じてチャネル作成

* `.env.default`を参考に`.env`に環境変数を設定してください

* 適当なタイミングでgem化する予定
