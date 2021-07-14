require 'rails_helper'

RSpec.describe DonationAddress, type: :model do
  before do
    @donation_address = FactoryBot.build(:donation_address)
  end

  describe '商品購入機能' do
    it 'postcodeが空だと登録できない' do
      @donation_address.postcode = ''
      @donation_address.valid?
      expect(@donation_address.errors.full_messages).to include("Postcode can't be blank")
    end
    it 'postcodeが「3桁ハイフン4桁」の半角文字列でないと登録できない' do
      @donation_address.postcode = '00-000'
      @donation_address.valid?
      expect(@donation_address.errors.full_messages).to include('Postcode is invalid')
    end
    it 'prefecture_idが空だと登録できない' do
      @donation_address.prefecture_id = ''
      @donation_address.valid?
      expect(@donation_address.errors.full_messages).to include('Prefecture is not a number')
    end
    it 'cityが空だと登録できない' do
      @donation_address.city = ''
      @donation_address.valid?
      expect(@donation_address.errors.full_messages).to include("City can't be blank")
    end
    it 'blockが空だと登録できない' do
      @donation_address.block = ''
      @donation_address.valid?
      expect(@donation_address.errors.full_messages).to include("Block can't be blank")
    end
    it 'phone_numberが空だと登録できない' do
      @donation_address.phone_number = ''
      @donation_address.valid?
      expect(@donation_address.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'phone_numberが10桁以上11桁以内の半角数値でなければ登録できない' do
      @donation_address.phone_number = '090123456'
      @donation_address.valid?
      expect(@donation_address.errors.full_messages).to include('Phone number is invalid')
    end
    it 'tokenが空だと登録できない' do
      @donation_address.token = nil
      @donation_address.valid?
      expect(@donation_address.errors.full_messages).to include("Token can't be blank")
    end
  end
end
