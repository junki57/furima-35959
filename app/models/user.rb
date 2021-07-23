class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]


  with_options presence: true do
    validates :nickname
    # validates :encrypted_password, presence: true, length: { minimum: 6 }
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: '半角英数字を両方含む'} , on: :create
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: '全角（漢字・ひらがな・カタカナ）での入力が必須' } do
      validates :first_name
      validates :family_name
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: '全角カタカナで入力して下さい。' } do
      validates :first_name_kana
      validates :family_name_kana
    end
    validates :birthday
  end
  has_many :items
  has_many :purchases
  has_many :sns_credentials
  has_one :card, dependent: :destroy

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    # userが登録済みであるか判断
   if user.persisted?
    sns.user = user
    sns.save
  end
  { user: user, sns: sns }
  end
end
