# 個人制作アプリ　locate

<img src = "https://github.com/yuuffff1212/locat/blob/master/locate.png" width = "800px">

## 概要

外出先で充電やWifiが完備されているカフェを探したい時に利用できるアプリケーションになっております。基本的な投稿機能や投稿に対するタグなどから、カフェの情報なども検索できるようになっております。

</br>

## 制作背景

もともと外で作業することが多かったため、簡単に充電やWifiが完備されているカフェを探したいと思った時にネットでググる作業をせずにカフェの情報を探したいと思い、自分で制作しようと考えました。

</br>

充電やWifiがあるカフェをネットで調べるのは手間がかかるため、アプリケーションの一つとして存在すればカフェを探す時間を効率的にすることができると思いました。

## 使用技術

* フロントエンド 
   * HTML/SCSS
   * Javascript
   * JQuery
   * Vue.js 2.6.14

* バックエンド
   * Ruby 3.0.1
   * Ruby on Rails 6.1.3
   * Rubocop (コード解析ツール)
   * Rspec (テストコード)
   
* インフラ環境
   * Docker / Docker-compose
   * AWS (VPC/ECS Fargate/EC2/RDS/S3/ALB/ACM/Route53)
   * CircleCI (CI/CD)
   * MySQL5.7 
   * Puma
   * Nginx

## ER図

<img src = "https://github.com/yuuffff1212/locat/blob/master/locat.ER%E5%9B%B3.png">

## 完了済みの実装一覧

* 基本機能
  * Deviseを使用した新規登録・ログイン・ログアウト機能
  * マイページ機能
    * プロフィール表示・プロフィール編集機能
    * マイページでプロフィール・投稿一覧・お気に入り一覧表示の切り替え機能
* 投稿機能
  * 新規投稿機能
    * active_storageを使用した画像投稿機能
    * ActiveHash、FormObjectを使用した投稿機能
    * 投稿の編集、削除機能
    * 投稿に対するコメント機能 (ajax通信による非同期処理)
    * タグ付け投稿機能 (配列化して表示させる機能)
  * 投稿に対する「いいね」機能 (非同期通信/Vue.js axios)
    * いいねした投稿の一覧表示機能
  * ユーザーフォロー機能(非同期処理/Vue.js axios)
    * フォロ一覧表示機能
    * フォロワ一覧表示機能

* その他
  * メニューバーのハンバーガーメニュー(JQuery)

## 現在実装している機能

* タグから投稿を検索できる
* いいね数に応じたランキング形式の投稿一覧表示機能
* GoogleMapApiによる地図の表示
* CircleCi(CI/CD)による自動デプロイ
