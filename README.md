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

| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| name          | string     | null: false |
| furigana      | string     | null: false |
| job           | string     | null: false |
| age           | integer    | null: false |
| gender        | string     | null: false |
| from          | string     | null: false |
| str           | integer    | null: false |
| con           | integer    | null: false |
| dex           | integer    | null: false |
| app           | integer    | null: false |
| siz           | integer    | null: false |
| edu           | integer    | null: false |
| possession    | text       |             |
| memo          | text       |             |
| custom_skills | json       |             |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :skills, through: :character_skills
- has_many :character_skills

## skills テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| name          | string     | null: false |
| default_value | integer    | null: false |

### Association

- has_many :character_skills

## character_skills テーブル

| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| character     | references | null: false, foreign_key: true |
| skill         | references | null: false, foreign_key: true |
| value         | integer    | null: false |

### Association

- belongs_to :character
- belongs_to :skill