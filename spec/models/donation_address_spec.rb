require 'rails_helper'

RSpec.describe DonationAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @donation_address = FactoryBot.build(:donation_address, user_id: user.id, item_id: item.id)
    sleep(0.1)
  end

  describe '商品購入機能' do

    context '商品が購入できる時' do
      it '必須項目が存在すれば登録できること' do
        expect(@donation_address).to be_valid
      end
      it '建物名の記入がなくても登録できること' do
        @donation_address.building = ''
        expect(@donation_address).to be_valid
      end
    end

    context '商品が購入できない時' do
      it 'postcodeが空だと登録できない' do
        @donation_address.postcode = ''
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'postcodeが「3桁ハイフン4桁」の半角文字列でないと登録できない' do
        @donation_address.postcode = '00-000'
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it 'postcodeにハイフンがないと登録できない' do
        @donation_address.postcode = '0000000'
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include('郵便番号は不正な値です')
      end
      it 'prefecture_idが空だと登録できない' do
        @donation_address.prefecture_id = ''
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include('発送先の地域は数値で入力してください')
      end
      it 'prefecture_idが1だと登録できない' do
        @donation_address.prefecture_id = '1'
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include('発送先の地域は1以外の値にしてください')
      end
      it 'cityが空だと登録できない' do
        @donation_address.city = ''
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'blockが空だと登録できない' do
        @donation_address.block = ''
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空だと登録できない' do
        @donation_address.phone_number = ''
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phone_numberが10桁以上11桁以内の半角数値でなければ登録できない' do
        @donation_address.phone_number = '090123456'
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'phone_numberが12桁以上では登録できない' do
        @donation_address.phone_number = '000000000000'
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'phone_numberが英数混合では登録できない' do
        @donation_address.phone_number = 'a123456789'
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include('電話番号は不正な値です')
      end
      it 'phone_numberが全角数字だと登録できない' do
        @donation_address.phone_number = '０００００００００００'
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'tokenが空だと登録できない' do
        @donation_address.token = nil
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("Tokenを入力してください")
      end
      it 'user_idが空だと登録できない' do
        @donation_address.user_id = nil
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("ユーザーを入力してください")
      end
      it 'item_idが空だと登録できない' do
        @donation_address.item_id = nil
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include("商品を入力してください")
      end
    end
  end
end
