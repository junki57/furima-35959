class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_one :purchase

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :shopping_date

  with_options presence: true do
    validates :image
    validates :name
    validates :introduction
    validates :price, format: { with: /\A[-]?[0-9]+(\.[0-9]+)?\z/ , message: '半角数値での入力が必須'}, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
  end
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :item_condition_id
    validates :postage_id
    validates :prefecture_id
    validates :shopping_date_id
  end
end
