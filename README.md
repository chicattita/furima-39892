# DB設計
## usersテーブル
| Column             | Type    | Option                    |
|-                   |-        |-                          |
| id(PK)             | integer | null: false               |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| date_of_birth      | date    | null: false               |

### Association
- has_many :items
- has_many :orders


## itemsテーブル
| Column             | Type       | Option                         |
|-                   |-           |-                               |
| id(PK)             | integer    | null: false                    |
| name               | string     | null: false                    |
| descritption       | text       | null: false                    |
| price              | integer    | null: false                    |
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| shipping_charge_id | integer    | null: false                    |
| shipping_date_id   | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| user(FK)           | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one : order


### ordersテーブル
| Column             | Type       | Option                         |
|-                   |-           |-                               |
| id(PK)             | integer    | null: false, foreign_key: true |                   
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |

### Association
- has_one :address
- belongs_to :item
- belongs_to :user




## addressesテーブル
| Column             | Type       | Option                         |
|-                   |-           |-                               |
| postal_code        | string     | null: false                    |
| prefecture _id     | integer    | null: false                    |
| city               | string     | null: false                    |
| addresses          | string     | null: false                    |
| building           | string     |                                |
| phone_number       | string     | null: false                    |
| order              | references | null: false, foreign_key: true |

### Association
- belongs_to :order
