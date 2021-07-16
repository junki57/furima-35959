require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    it 'imageが空だと登録できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("画像を入力してください")
    end
    it 'nameが空だと登録できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("商品名を入力してください")
    end
    it 'introductionが空だと登録できない' do
      @item.introduction = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("商品の説明を入力してください")
    end
    it 'category_idが1だと登録できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('カテゴリーは1以外の値にしてください')
    end
    it 'item_condition_idが1だと登録できない' do
      @item.item_condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('商品の状態は1以外の値にしてください')
    end
    it 'postage_idが1だと登録できない' do
      @item.postage_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('配送料は1以外の値にしてください')
    end
    it 'prefecture_idが1だと登録できない' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('発送元の地域は1以外の値にしてください')
    end
    it 'shopping_date_idが1だと登録できない' do
      @item.shopping_date_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include('発送までの日数は1以外の値にしてください')
    end
    it 'priceが空だと登録できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("価格を入力してください")
    end
    it 'priceが¥300以下だと登録できない' do
      @item.price = 100
      @item.valid?
      expect(@item.errors.full_messages).to include('価格は300以上の値にしてください')
    end
    it 'priceが¥9,999,999以上だと登録できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('価格は9999999以下の値にしてください')
    end
    it 'priceが半角数値でないと登録できない' do
      @item.price = '３０００'
      @item.valid?
      expect(@item.errors.full_messages).to include('価格は数値で入力してください')
    end
    it 'ユーザーが紐づいていなければ登録できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('Userを入力してください')
    end
  end
end
