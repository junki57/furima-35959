FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {'kkk@gmail.com'}
    password              {'00000aa'}
    password_confirmation {password}
    first_name            {'太郎'}
    family_name           {'山田'}
    first_name_kana       {'タロウ'}
    family_name_kana      {'ヤマダ'}
    birthday              {'19960101'}
  end
end