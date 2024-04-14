Docker で Redmine の開発環境を構築する
=======================================

docker 環境で Redmine(webpack導入済) の開発するための環境です。

## 前提

Docker がインストール済であること (リポジトリ名に wsl2 と付いているが、他の環境でも問題ないはずです)

## 利用方法

1. リポジトリをクローンします。

```
$ git clone https://github.com/tohosaku/redmine-docker-wsl2.git

# webpack 導入済のブランチをクローンします。
$ git clone -b simpacker https://github.com/tohosaku/redmine

$ cd redmine-docker-wsl2
```

2. database.yml.tmpl にデータベースのパスワードを追記して、../redmine/config にコピー
3. dbpass.env.tmpl にデータベースのパスワードを追記して、.dbpass.env として保存します。
4. rubygems、npm パッケージを導入します。

```
# redmine は、node_modulesの存在をチェックするので、先に npmモジュールを導入する。
$ ./dc.sh run --rm webpack webpack.sh
$ ./dc.sh run --rm redmine redmine.sh
```

5. サービスを起動します。

```
$ ./dc.sh up -d
```

6. localhost:3000 を開いて redmine が起動しているとを確認します。

## アセットのコンパイル

production 環境のために、アセットをコンパイルすることもできます。

```
$ ./dc_prod.sh run --rm webpack yarn release
```
