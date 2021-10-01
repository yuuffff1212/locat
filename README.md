# 個人制作アプリ　[locate](https://locat-app.herokuapp.com/)

<img src = "https://github.com/yuuffff1212/locat/blob/master/%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%BC%E3%83%B3%E3%82%B7%E3%83%A7%E3%83%83%E3%83%88%202021-10-01%2019.36.48.png" width = "800px">

## 概要

外出先で充電やWifiが完備されているカフェを探したい時に利用できるアプリケーションになっております。基本的な投稿機能や投稿に対するタグなどから、カフェの情報なども検索できるようになっております。

* アプリケーションの接続先はこちらから
* [locate](https://locat-app.herokuapp.com/)
* 一時的にHerokuへアップ(接続に少々お時間がかかる場合がございます)
* ログイン方法
  * ログインユーザー:  test-user
  * ログインEmail:    test-user@gmail.com
  * ログインPassword: testuser0000

</br>

## 制作背景

もともと外出先で作業する頻度が多く、充電やWifiが完備されているカフェなどを探すことに手間がかかっておりました。調べる媒体はほとんど口コミサイトばかりで、アプリケーションなどで簡単にカフェを探すことができればと考えていました。



</br>

その背景から、充電やWifiがあるカフェをネットで調べるのは手間がかかるため、アプリケーションの一つとして存在すればカフェを探す時間を短縮して作業に集中できると思い開発してみました。

### 企画概要

* ペルソナ
  * 外出先カフェなどでPCで作業をするフリーランスの方や学生
  * 長時間カフェなど利用する方
  * 30代半までの男性や女性
  * 充電やWifi、喫煙スペースがあるカフェを求めているユーザー
  * カフェを探す作業に時間をかけたくない方
  
* こちらのペルソナを元に要件定義をしました。

## 実装で工夫したポイント

### ajax通信をVue.jsを使用して実装したこと

* 投稿のお気に入り登録やユーザーのフォロー機能をTwitterのような形で実現させることができた。
* 取り入れてみたかったモダン技術で実装をすることができたこと。
  
  
### インフラ環境の差別化

* ECS fargateでインフラ環境を構築したこと。
* circleCIによる自動テスト・デプロイを導入したこと。
* 開発環境をDockerを用いて開発したこと。



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

## インフラ構成図

<img src = "https://github.com/yuuffff1212/locat/blob/master/Untitled.png">

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
* GoogleMapApiによる地図の表示
