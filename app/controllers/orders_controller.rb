# orders_controller.rb
class OrdersController < ApplicationController
  before_action :set_order, only: [:index, :create]
  before_action :set_public_key, only: [:index, :create]
  before_action :load_item, only: [:index, :create]

  def index
    @order_address = OrderAddress.new(user_id: current_user.id)

    if current_user.id == @order_address.user_id || @order_address.nil?
      redirect_to root_path 
    end
  end

  def create
    @order_address = OrderAddress.new(order_params)

    if @order_address.valid?
       pay_item
       @order_address.save

       redirect_to root_path
    else
       gon.public_key = ENV['PAYJP_PUBLIC_KEY']
       render :index, status: :unprocessable_entity
    end
  end

  def new
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_public_key
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def load_item
    @item = Item.find(params[:item_id])
  end
end
