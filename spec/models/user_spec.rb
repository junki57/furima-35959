require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe "ユーザー新規登録" do
    it "nicknameが空だと登録できない" do
      @user.nickname = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it "emailが空では登録できない" do
      @user.email = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "同じメールアドレスは登録できない" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it "メールアドレスは、@を含む必要がある" do
      @user.email = 'hogegmail.com'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it "passwordが空では登録できない" do
      @user.password = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it "パスワードは、6文字以上での入力が必須である" do
      @user.password = '0000a'
      @user.password_confirmation = '0000a'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it "パスワードは、半角英数字混合での入力が必須である" do
      @user.password = '0000000'
      @user.password_confirmation = '0000000'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password 半角英数字を両方含む')
    end
    it "パスワードとパスワード（確認）は、値の一致が必須である" do
      @user.password_confirmation = '101010101010'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "first_nameが空では登録できない" do
      @user.first_name = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it "first_nameは全角（漢字・ひらがな・カタカナ）での入力が必須" do
      @user.first_name = 'yamada'
       @user.valid?
       expect(@user.errors.full_messages).to include("First name 全角（漢字・ひらがな・カタカナ）での入力が必須")
    end
    it "family_nameが空では登録できない" do
      @user.family_name = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("Family name can't be blank")
    end
    it "family_nameは全角（漢字・ひらがな・カタカナ）での入力が必須" do
      @user.family_name = 'tarou'
       @user.valid?
       expect(@user.errors.full_messages).to include("Family name 全角（漢字・ひらがな・カタカナ）での入力が必須")
    end
    it "first_name_kanaが空では登録できない" do
      @user.first_name_kana = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it "first_name_kanaは、全角（カタカナ）での入力が必須である" do
      @user.first_name_kana = 'やまだ'
       @user.valid?
       expect(@user.errors.full_messages).to include("First name kana 全角カタカナで入力して下さい。")
    end
    it "family_name_kanaが空では登録できない" do
      @user.family_name_kana = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("Family name kana can't be blank")
    end
    it "family_name_kanaは、全角（カタカナ）での入力が必須である" do
      @user.family_name_kana = 'たろう'
       @user.valid?
       expect(@user.errors.full_messages).to include("Family name kana 全角カタカナで入力して下さい。")
    end
    it "birthdayが空では登録できない" do
      @user.birthday = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end

  end
end
