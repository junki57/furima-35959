FactoryBot.define do
  factory :donation_address do
    postcode                {'000-0000'}
    prefecture_id           {2}
    city                    {'test'}
    block                   {'2222'}
    phone_number            {'09012345678'}
  end
end
