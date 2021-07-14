

<img width="700" alt="header_logo" src="https://user-images.githubusercontent.com/79980351/123764919-38235880-d900-11eb-87a9-622eab84fa61.png">

# Shuffle(シャッフル) 色々な人を混ぜ合わせるコミュニティアプリ
サイトURLはこちら https://shuffle21.xyz/
* 自分でグループを作れて、メンバー同士で情報発信ができるコミュニティアプリです。
* レスポンシブ対応しているので、スマホからもご確認いただけます。
## 技術的なポイント
 * AWS EC2/RDSを用いたRails本番環境構築
 * AWS CertbotでSSL証明書を発行し、SSL化
 * 独自ドメイン取得、使用
 * N+1問題を意識したパフォーマンス
 * Gitによる自動デプロイ
 * RSpecを取り入れたバグの検知
 * Ajaxを用いた非同期処理（フォロー機能、いいね機能、コメント機能）
 * Bootstrapによるレスポンシブ対応
 * Rubocopを使用したコード規約に沿った開発
 * 複数キーワードに対応した検索
 * 8つのモデルをそれぞれ関連付けて使用

<img width="700" alt="スクリーンショット 2021-06-29 17 29 07" src="https://user-images.githubusercontent.com/79980351/123764226-8e43cc00-d8ff-11eb-8f57-37e6ef2f08c8.png">
<img width="700" alt="スクリーンショット 2021-07-12 20 18 43" src="https://user-images.githubusercontent.com/79980351/125279131-8730ab00-e34e-11eb-9f33-3780c82096fb.png">

## 制作背景
コロナ渦により、オンライン環境でのプログラミング学習がふえてきました。  
そこで下記問題があった為、問題を解決したいと考え、アプリをつくろうとおもいました。  

<問題点>
* オンライン環境で、顔が見えずなかなか喋りかけれない。
* 仲間同士で情報交換をしたい。
* スクールの学習が終わった後でも、一緒に切磋琢磨できる仲間が欲しい。

## ターゲットユーザー
プログラミング初学者

## 主な利用シーン
* イベント開催（朝活等）の投稿
* 役立つ情報の共有
* ユーザー同士の交流

## 設計書
* [画面遷移図](https://drive.google.com/file/d/1WcLErtK_tbyAiFMkTYXFZEMqAwQiQV0C/view?usp=sharing)
* [ER図](https://drive.google.com/file/d/1ptPvzaPjyf21LPoxMy6aJP3uTTkrWB62/view?usp=sharing)
* [テーブル定義書](https://docs.google.com/spreadsheets/d/1SqSQQm1gZpTHf3OcX7xo8yNg7s_4f1dENl2DI5zy_GQ/edit?usp=sharing)
* [詳細設計](https://drive.google.com/file/d/11xb3GUXV8LYU4EcFpRz5xPnGj17yHM9r/view?usp=sharing)
* [アプリ土台作りのコマンド一覧](https://docs.google.com/spreadsheets/d/1A6Ea8L6Mus-K7u3EqCJokGCaN2bOZ_SFgmy01pj3FFI/edit?usp=sharing)
## 使用技術
* Ruby 2.6.3
* Ruby on Rails 5.2.5
* MySQL 5.7.22
* Nginx
* Puma
* AWS
  * VPC
  * EC2
  * RDS
  * S3
* RSpec

## 機能一覧
* 会員＆管理者認証（devise）
  * 日本語化
  * ゲストログイン
* 管理機能
  * 会員ステータスの管理
* 会員退会機能(論理削除）
* 投稿機能
  * 投稿編集、削除機能
  * 画像投稿(refile)
  * コメント機能(Ajax)
  * いいね機能(Ajax)
  * YouTubeの投稿機能（URLを投稿し、投稿詳細ページにて動画が再生できる）
* グループ機能
  * グループの作成
  * メンバー加入、脱退機能
  * 加入メンバーの一覧表示
* フォロー機能(Ajax)
  * フォロー＆フォロワーの一覧表示
* グループ一覧と会員一覧機能
* N+1問題への対応（gem'bullet'）
* 検索機能
  * 複数キーワードでの検索
  * 複数モデル同時検索
  * 空文字対策
* ランキング機能
  * グループのメンバー加入数でのランキング
  * 投稿のいいね数のランキング
* ページング機能(kaminari)
  * コンテンツの一覧を並び替えし、最新順に表示
* 無限スクロール(jScroll)
  * 会員一覧、グループ一覧、投稿一覧にて使用
* タブメニュー の切り替え
  * 会員詳細、グループ詳細、検索結果にて使用 
* UI/UX
  * レスポンシブ対応（スマートフォン/タブレット)  
 
[その他・機能・実装の詳細はこちら](https://docs.google.com/spreadsheets/d/1ZBt6QmwcLDN9bYTRuAtxePyoyASKBGyHLJTQEikMtGQ/edit?usp=sharing)
## テスト
* RSpec
  * 単体テスト(model)
  * 統合テスト(feature)
  * リクエストテスト(requests)
 ## 静的コード解析ツール
  * Rubocop
 
## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9  

## 本番環境
- AWS (EC2、RDS)
- Nginx、 Puma
- Github actionを用いた自動デプロイ

## ユーザーからのフィードバック
* [ポートフォリオに対するフィードバック](https://docs.google.com/spreadsheets/d/1L-M3-jYlHcIsOXhosFG5ke3RuXdZwe_r7sNHqSozTc0/edit?usp=sharing)
* [現役エンジニアからのポートフォリオに対するフィードバック.pdf](https://github.com/hikaru-webcamp/PF_Shuffle/files/6759057/default.pdf)

## 使用素材
* [Pinterest](https://www.pinterest.jp/pin/657947826807735666/)
* [Free video clips](https://mazwai.com/)
