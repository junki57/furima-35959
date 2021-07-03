class ItemsController < ApplicationController
  # before_action :authenticate_user!


  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params) 
  end

  private
  def item_params
    params.require(:item).permit(:name, :image, :introduction, :category_id, :item_condition_id, :postage_id, :prefecture_id, :shopping_date_id, :price).merge(user_id: current_user.id)
  end
end
