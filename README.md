# DB設計

## users table

| Column                | Type           | Option           |
| --------------------- | -------------- | ---------------- |
| nickname              | string         | null: false      |
| email                 | string         | null: false      |
| encrypted_password    | string         | null: false      |
| password_confirmation | string         | null: false      |
| first_name            | string         | null: false      |
| family_name           | string         | null: false      |
| first_name_kana       | string         | null: false      |
| family_name_kana      | string         | null: false      |
| birth_year            | integer        | null: false      |
| birth_month           | integer        | null: false      | 
| birth_day             | integer        | null: false      |

### Association

- has_many : items
- has_many : purchases

## items table

| Column                | Type           | Option           |
| --------------------- | -------------- | ---------------- |
| name                  | string         | null: false      |
| introduction          | string         | null: false      |
| image                 |                | null: false      |
| category              | string         | null: false      |
| item_condition        | string         | null: false      |
| postage               | string         | null: false      |
| region                | string         | null: false      |
| shopping_date         | integer        | null: false      |
| price                 | integer        | null: false      |
| user_id               | string         | null: false      |

### Association

- belongs_to : users
- has_many : purchases

## purchases table

| Column                | Type           | Option           |
| --------------------- | -------------- | ---------------- |
| user_id               | string         | null: false      |
| item_id               | string         | null: false      |
| residence_id          | string         | null: false      |

### Association

- belongs_to : users
- belongs_to : items
- belongs_to : residences

## residences table

|Column                | Type           | Option           |
| --------------------- | -------------- | ---------------- |
| postcode              | integer        | null: false      |
| prefecture            | integer        | null: false      |
| city                  | string         | null: false      |
| block                 | integer        | null: false      |
| building              | string         | null: false      |
| phone_number          | integer        | null: false      |

### Association

- has_one : purchase
- belongs_to : users