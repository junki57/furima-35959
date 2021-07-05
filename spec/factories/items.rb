FactoryBot.define do
  factory :item do
    name                {'test'}
    introduction        {'test'}
    category_id         {}
    item_condition_id   {}
    postage_id          {}
    prefecture_id       {}
    shopping_date_id    {}
    price               {3000}
    user                {}
  end
end
