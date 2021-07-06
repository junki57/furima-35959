require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    it "imageが空だと登録できない" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it "nameが空だと登録できない" do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end
    it "introductionが空だと登録できない" do
      @item.introduction = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Introduction can't be blank")
    end
    it "category_idが1だと登録できない" do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Category must be other than 1")
    end
    it "item_condition_idが1だと登録できない" do
      @item.item_condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Item condition must be other than 1")
    end
    it "postage_idが1だと登録できない" do
      @item.postage_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Postage must be other than 1")
    end
    it "prefecture_idが1だと登録できない" do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
    end
    it "shopping_date_idが1だと登録できない" do
      @item.shopping_date_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Shopping date must be other than 1")
    end
    it "priceが空だと登録できない" do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it "priceが¥300以下だと登録できない" do
      @item.price = 100
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end
    it "priceが¥9,999,999以上だと登録できない" do
      @item.price = 10000000
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
    end
    it "priceが半角数値でないと登録できない" do
      @item.price = '３０００'
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end
    it "ユーザーが紐づいていなければ登録できない" do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end
  end
end
