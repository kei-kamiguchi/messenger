# カラムの追加
https://qiita.com/azusanakano/items/a2847e4e582b9a627e3a
# emailのカラムにインデックスを追加
```
$ rails g migration add_index_to_users_email
```
[db/migrate/xxxxxxxxx_add_index_to_users_email.rb]
```
class AddIndexToUsersEmail < ActiveRecord::Migration[5.2]
 def change
   add_index :users, :email, unique: true
 end
end
```
# 保存する前にメールアドレスの値を小文字に変換する方法です。
```
class User < ApplicationRecord
  (省略)
  before_validation { email.downcase! }
end
```
# セキュアパスワードの設定
- 対象のモデルに「password_digestカラム」を持たせる
- 対象のモデルに「has_secure_password」を追記
- gem 'bcrypt'のインストール

# 疑問
delegateの使い方がわからない
　
# テキスト修正
「ログインしていないユーザはログイン画面に飛ばす」の部分
```
if @current_user == nil  #すべてnilになる
if current_user == nil
```
https://diver.diveintocode.jp/curriculums/495
