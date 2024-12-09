# テーブル設計

## users テーブル

| Column              | Type   | Options     |
| ------------------- | ------ | ----------- |
| name                | string | null: false |
| email               | string | null: false, unique: true |
| encrypted_password  | string | null: false |

### Association

- has_many :characters

## characters テーブル

| Column       | Type       | Options     |
| ------------ | ---------- | ----------- |
| name         | string     | null: false |
| furigana     | string     | null: false |
| job          | string     | null: false |
| age          | string     | null: false |
| gender       | string     | null: false |
| from         | string     | null: false |
| str          | string     | null: false |
| con          | string     | null: false |
| dex          | string     | null: false |
| app          | string     | null: false |
| siz          | string     | null: false |
| edu          | string     | null: false |
| possession   | text       | null: false |
| memo         | text       | null: false |
| user         | references | null: false, foreign_key: true |

### Association

- belongs_to :user