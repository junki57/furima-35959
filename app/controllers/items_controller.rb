class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show,]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :aaa, only: [:edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  
  

  private
  def item_params
    params.require(:item).permit(:name, :image, :introduction, :category_id, :item_condition_id, :postage_id, :prefecture_id, :shopping_date_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def aaa
    if current_user.id != @item.user.id
      redirect_to root_path 
   end
  end
end
