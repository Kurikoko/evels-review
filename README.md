# テーブル設計

## usersテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| name               | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |

### Association
- has_many  :place_users
- has_many  :place, through: :place_users
- has_many  :reviews

## placesテーブル

| Column         | Type    | Options     |
| -------------- | ------- | ----------- |
| place_name     | string  | null: false |
| area_id        | integer | null: false |
| line_kinds_id  | integer | null: false |
| carrier        | string  | null: false |
| fee_id         | integer | null: false |
| backup_line_id | integer | null: false |
| wifi_id        | integer | null: false |

### Association
- has_many  :place_users
- has_many  :users, through: :place_users
- has_many  :reviews

## place_users_テーブル

| Column | Type       | Options                        |
| ------ | -----------| ------------------------------ |
| user   | references | foreign_key: true, null: false |
| place  | references | foreign_key: true, null: false |


### Association

- belongs_to  :user
- belongs_to  :place

## reviewsテーブル
| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| user           | references | foreign_key: true, null: false |
| place          | references | foreign_key: true, null: false |
| download       | integer    | null: false                    |
| upload         | integer    | null: false                    |
| comment        | text       | null: false                    |

### Association

- belongs_to  :user
- belongs_to  :place
