class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :items_params, only:[:create, :index]
  before_action :contributor_confirmation, only: [:create, :index]

  def index
    @donation_address = DonationAddress.new
  end


  def create
    @donation_address = DonationAddress.new(donation_params)
    items_params
    if @donation_address.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  
      Payjp::Charge.create(
        amount: @item.price,  # 商品の値段
        card: donation_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
      @donation_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private 

  def donation_params
    params.require(:donation_address).permit(:user_id, :item_id, :postcode, :prefecture_id, :city, :block, :building, :phone_number, :purchase ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def items_params
    @item = Item.find(params[:item_id])
  end

  def contributor_confirmation
    redirect_to root_path if current_user == @item.user || !@item.purchase.nil?
  end
end