# アプリケーション作成目的
趣味で動画編集を始めた際、専門的に編集技術をアウトプットできてかつトラブルシューティングできるようなサイトが存在しなかったため
たくさんの編集技術や素材などの知識を標準化させるような、Qiitaの動画編集者版を作り、誰もが動画編集をできることを目的とした
webアプリケーションを作成してみたいと考えたため。
 
#### topページ
[![Image from Gyazo](https://i.gyazo.com/caefe181eb423b3c9e44975c87e63eb1.png)](https://gyazo.com/caefe181eb423b3c9e44975c87e63eb1)  
#### サインアップ（ログイン）  
[![Image from Gyazo](https://i.gyazo.com/5a7be30bf56a420221bc91d0120d2717.gif)](https://gyazo.com/5a7be30bf56a420221bc91d0120d2717)  
#### 投稿ページ（タグ機能）
[![Image from Gyazo](https://i.gyazo.com/c4f280aada14b56b39087bfef6fbee01.gif)](https://gyazo.com/c4f280aada14b56b39087bfef6fbee01)  
#### 詳細ページ（編集・コメント）  
[![Image from Gyazo](https://i.gyazo.com/bbad7e49d094cddcc3bb4ea9c57f30b5.png)](https://gyazo.com/bbad7e49d094cddcc3bb4ea9c57f30b5)  
#### マイページ
[![Image from Gyazo](https://i.gyazo.com/a7e2195558ac7be86b6ef01697131bae.png)](https://gyazo.com/a7e2195558ac7be86b6ef01697131bae)  

#### [⇨（現在閉鎖中)Editmaster](http://www.editmasterhub.com/)  
##### ログイン用アカウント  
メールアドレス: hogehoge@gmail.com  
パスワード: hogehoge21  

## 搭載機能
### 実装
ユーザー管理機能  
Markdownによる投稿機能（一部使用誤差あり）  
YoutubeのURLを取得しての動画投稿  
検索機能  
タグ機能  
コメント機能  
AWSのEC2サーバーを使ったデプロイ環境  
Capistranoを使った自動デプロイ機能  
ドメイン取得  
Google認証
[![Image from Gyazo](https://i.gyazo.com/102b70c55422cecd9e79c8808ecdaee0.gif)](https://gyazo.com/102b70c55422cecd9e79c8808ecdaee0)

## version
ruby 2.5.7  
Rails 5.2.3  
MySQL  
Github  
AWS  
Visual Studio Code  
## DB設計 

### usersテーブル

|Column|Type|Options|
|------|----|-------|
|image|string|
|nickname|string|null: false,index: true|
|mail|string|null: false, unipue: true|

#### Association
- has_many :articles
- has_many :comments
- has_many :groups, through: :group_users
- has_many :group_users
- has_many :likes, dependent: :destroy

### groupsテーブル

|Column|Type|Options|
|------|----|-------|
|group_name|string|null: false, unipue: true|

#### Association
- has_many :users, through: :group_users
- has_many :group_users
- has_many :articles


### groups_usersテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

#### Association
- belongs_to :group
- belongs_to :user

### articlesテーブル

|Column|Type|Options|
|------|----|-------|
|title|text|null: false,index: true|
|text|text|null: false,index: true|
|image|string|null: true|
|user_id|integer|foreign_key: true|


#### Association
- belongs_to :user
- has_many :comments
- has_many :likes, dependent: :destroy

### commentsテーブル

|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|image|string|null: true|
|user_id|integer|null: false, foreign_key: true|
|article_id|integer|null: false, foreign_key: true|

#### Association
- belongs_to :article
- belongs_to :user

### likesテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|article_id|references|null: false, foreign_key: true|

#### Association
- belongs_to :user
- belongs_to :article
