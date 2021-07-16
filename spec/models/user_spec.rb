require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'nicknameが空だと登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end
    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
    end
    it '同じメールアドレスは登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end
    it 'メールアドレスは、@を含む必要がある' do
      @user.email = 'hogegmail.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end
    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end
    it 'パスワードは、6文字以上での入力が必須である' do
      @user.password = '0000a'
      @user.password_confirmation = '0000a'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end
    it 'パスワードは、半角英数字混合での入力が必須である' do
      @user.password = '0000000'
      @user.password_confirmation = '0000000'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワード半角英数字を両方含む')
    end
    it 'パスワードとパスワード（確認）は、値の一致が必須である' do
      @user.password_confirmation = '101010101010'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end
    it 'first_nameが空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("名前を入力してください")
    end
    it 'first_nameは全角（漢字・ひらがな・カタカナ）での入力が必須' do
      @user.first_name = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前全角（漢字・ひらがな・カタカナ）での入力が必須')
    end
    it 'family_nameが空では登録できない' do
      @user.family_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字を入力してください")
    end
    it 'family_nameは全角（漢字・ひらがな・カタカナ）での入力が必須' do
      @user.family_name = 'tarou'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字全角（漢字・ひらがな・カタカナ）での入力が必須')
    end
    it 'first_name_kanaが空では登録できない' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("名前(カナ)を入力してください")
    end
    it 'first_name_kanaは、全角（カタカナ）での入力が必須である' do
      @user.first_name_kana = 'やまだ'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前(カナ)全角カタカナで入力して下さい。')
    end
    it 'family_name_kanaが空では登録できない' do
      @user.family_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字(カナ)を入力してください")
    end
    it 'family_name_kanaは、全角（カタカナ）での入力が必須である' do
      @user.family_name_kana = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字(カナ)全角カタカナで入力して下さい。')
    end
    it 'birthdayが空では登録できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("生年月日を入力してください")
    end
  end
end
