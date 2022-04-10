class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @current_cart.line_items.each do |item|
      @order.line_items << item
      item.cart_id = nil
    end
    @order.save
    Cart.destroy(session[:cart_id])
    session[:cart_id] = nil
    redirect_to root_path, alert: 'Order placed successfully :)'
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to products_path, alert: 'Order Cancelled!', status: :see_other
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :address, :contact, :payment_mode)
  end
end
