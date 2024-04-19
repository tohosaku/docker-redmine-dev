Docker で Redmine の開発環境を構築する
=======================================

docker 環境で Redmine の開発するための環境です。

## 前提

Docker がインストール済であること

## 利用方法

1. リポジトリをクローンし、イメージをビルドします

```
$ git clone https://github.com/tohosaku/docker-redmine-dev.git

$ git clone -b simpacker https://github.com/redmine/redmine

$ cd docker-remdmine-dev
$ ./redmine build
```

2. database.yml.tmpl にデータベースのパスワードを追記して、../redmine/config にコピー
3. dbpass.env.tmpl にデータベースのパスワードを追記して、.dbpass.env として保存します。
4. サービスを起動します。

```
$ ./redmine
```

5. localhost:3000 を開いて redmine が起動しているとを確認します。
