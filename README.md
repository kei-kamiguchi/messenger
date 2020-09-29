# スコープ
## 使用するメリット
独自の検索機能をメソッドとして切り出すことができる（クラスメソッドとして使用できる）
- コードの可読性向上
- 再利用可
- 仕様変更が容易
## 送り手と受け手の「組み合わせ」で判定するbetweenスコープ
```
scope :between, -> (sender_id, recipient_id) do
  where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND  conversations.recipient_id =?)", sender_id, recipient_id, recipient_id, sender_id)
end
```
わかりやすくするためscopeを使わず、OR以降の条件も一旦外して解説します。
なお、ここでは、`sender_id=1`, `recipient_id=2`としています。
```
Conversation.where("(conversations.sender_id = ? AND conversations.recipient_id = ?)", 1,2)

# 上と下の内容は同じです。

Conversation.where("(conversations.sender_id = 1 AND conversations.recipient_id = 2)")
```
whereメソッド内で「?」を使用することで、「?」に代入するものを切り出すことができます。

さらに、`sender_id = 2`、`recipient_id = 1`のレコードがあるかも検索する必要があるため、以下のようになる。
```
Conversation.where("(conversations.sender_id = 1 AND conversations.recipient_id = 2) OR (conversations.sender_id = 2 AND conversations.recipient_id = 1)")
```
「?」を使用して代入を活用すると
```
Conversation.where("(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)", 1, 2, 2, 1)
```
最後に「scope」の引数を使用した記述をすることで、元の形になります。

# クエリストリング
URLにパラメータを持たせることができることで、viewからcontrollerにパラメータを渡す方法
```
<%= link_to '以前のメッセージ', '?m=all' %>
# 以下のように書き換えることもできる
<%= link_to '以前のメッセージ', m: 'all' %>
# 以下のようにパラメータを抽出できる
params[:m]
# => 'all'
```
# validates_uniqueness_of
以下は、特定のテーブルに対し、sender_idに対するrecipient_idは一意であるという制約を持たせている。
```
validates_uniqueness_of :sender_id, scope: :recipient_id
```
