<img width="700" alt="header_logo" src="https://user-images.githubusercontent.com/79980351/123764919-38235880-d900-11eb-87a9-622eab84fa61.png">

# Shuffle シャッフル 色々な人を混ぜ合わせるコミュニティアプリ
サイトURLはこちら http://shuffle21.xyz/
* 自分でグループを作れて、メンバー同士で情報発信ができるコミュニティアプリです。
* 自身がもつ情報をグループ内でかんたんに共有(YouTubeも共有可)できます。
* レスポンシブ対応しているので、スマホからもご確認いただけます。
* UI/UXを意識し、ユーザーが使いやすいように、アプリをシンプルに設計しました。

<img width="700" alt="スクリーンショット 2021-06-29 17 29 07" src="https://user-images.githubusercontent.com/79980351/123764226-8e43cc00-d8ff-11eb-8f57-37e6ef2f08c8.png">
<img width="700" alt="スクリーンショット 2021-06-29 18 45 42" src="https://user-images.githubusercontent.com/79980351/123776585-61e17d00-d90a-11eb-9786-65af1809bcb1.png">

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
* ユーザー＆管理者認証（devise）
  * 日本語化
  * ゲストログイン
* 投稿機能
  * 投稿編集、削除機能
  * 画像投稿(refile)
  * コメント機能(Ajax)
  * いいね機能(Ajax)
* グループ機能（メンバー加入、脱退）
* YouTube投稿機能（投稿フォームにてYouTubeの埋め込み）
* グループ一覧とユーザー一覧機能
* 会員とグループと投稿の検索機能
* ランキング機能（グループと投稿）
* ページング機能(kaminari)
* 無限スクロール(jscroll)
* タブメニュー：ユーザーが加入したグループ一覧画面 / 投稿一覧画面切り替え機能 
* UI/UX
 * レスポンシブ対応（スマートフォン/タブレット)
## テスト
* RSpec
 * 単体テスト(model)
 * 統合テスト(feature)

## チャレンジ要素一覧
* [チャレンジ要素一覧はこちら](https://docs.google.com/spreadsheets/d/1ZBt6QmwcLDN9bYTRuAtxePyoyASKBGyHLJTQEikMtGQ/edit?usp=sharing)
## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## FB
* [ポートフォリオに対するフィードバック](https://docs.google.com/spreadsheets/d/1L-M3-jYlHcIsOXhosFG5ke3RuXdZwe_r7sNHqSozTc0/edit?usp=sharing)

## 使用素材
* [Pinterest](https://www.pinterest.jp/pin/657947826807735666/)
* [Free video clips](https://mazwai.com/)
