FactoryBot.define do
  factory :item do
    name                {'test'}
    introduction        {'test'}
    category_id         {2}
    item_condition_id   {2}
    postage_id          {2}
    prefecture_id       {2}
    shopping_date_id    {2}
    price               {3000}
    
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png') 
    end
  end
end
