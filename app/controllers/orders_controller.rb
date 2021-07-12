class OrdersController < ApplicationController
  def index
    @donation_address = DonationAddress.new
  end


  def create
    @donation_address = DonationAddress.new(donation_params)
    if @donation_address.valid?
      @donation_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private 

  def donation_params
    params.require(:donation_address).permit(:user_id, :item_id, :postcode, :prefecture_id, :city, :block, :building, :phone_number, :purchase ).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end