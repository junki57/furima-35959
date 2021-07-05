class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    # validates :encrypted_password, presence: true, length: { minimum: 6 }
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: '半角英数字を両方含む'}
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/ , message: '全角（漢字・ひらがな・カタカナ）での入力が必須'} do
      validates :first_name
      validates :family_name
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナで入力して下さい。'} do
      validates :first_name_kana 
      validates :family_name_kana
    end
    validates :birthday
  end
  has_many :items
end
