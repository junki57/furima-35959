class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :items_params, only: [:create, :index]
  before_action :contributor_confirmation, only: [:create, :index]

  def index
    @donation_address = DonationAddress.new
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)

    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_token)
      @card = customer.cards.first
    end
  end

  def create
    @donation_address = DonationAddress.new(donation_params)
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    card = Card.find_by(user_id: current_user.id)
    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_token)
      @card = customer.cards.first
      @donation_address.token = current_user.card.customer_token
    end

    if @donation_address.valid?
       pay_item
       @donation_address.save
       redirect_to root_path
    else
      render :index
    end
  end

  private

  def donation_params
    params.require(:donation_address).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number, :purchase).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def items_params
    @item = Item.find(params[:item_id])
  end

  def contributor_confirmation
    redirect_to root_path if current_user == @item.user || !@item.purchase.nil?
  end

  def pay_item
    if @card.present?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      customer_token = current_user.card.customer_token
      Payjp::Charge.create(
        amount: @item.price,
        customer: customer_token,
        currency: 'jpy'
      )
    else
      Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      Payjp::Charge.create(
        amount: @item.price,
        card: donation_params[:token],
        currency: 'jpy'
      )
    end
  end
end
