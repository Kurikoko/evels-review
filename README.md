## アプリケーション名
### Evels Tokyo  
## アプリケーション概要
### EVEnt Line Speed 


## URL

## テスト用アカウント

## 利用方法

## 目指した課題解決

## 洗い出した要件

## 実装した機能についての画像やGIF及びその説明

## 実装予定の機能

## データベース設計

## テーブル設計

### usersテーブル

| Column             | Type      | Options                   |
| ------------------ | --------- | ------------------------- |
| name               | string    | null: false               |
| email              | string    | null: false, unique: true |
| encrypted_password | string    | null: false               |

#### Association
- has_many  :reviews

### placesテーブル

| Column             | Type      | Options                   |
| ------------------ | --------- | ------------------------- |
| place_name         | string    | null: false               |
| area_id            | integer   | null: false               |
| line_kinds_id      | integer   | null: false               |
| carrier            | string    | null: false               |
| fee_id             | integer   | null: false               |
| backup_line_id     | integer   | null: false               |
| wifi_id            | integer   | null: false               |

#### Association
- has_many  :reviews


### reviewsテーブル
| Column            | Type       | Options                                                        |
| ----------------- | ---------- | -------------------------------------------------------------- |
| user              | references | foreign_key: true, null: false                                 |
| place             | references | foreign_key: true, null: false, uniqueness: {scope :: user_id} |
| download          | float      | null: false                                                    |
| upload            | float      | null: false                                                    |
| comment           | text       | null: false                                                    |

#### Association

- belongs_to  :user
- belongs_to  :place

## ローカルでの動作方法