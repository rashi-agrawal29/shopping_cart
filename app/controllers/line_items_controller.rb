class LineItemsController < ApplicationController
  before_action :find_line_item, except: [:create]

  def create
    chosen_product = Product.find(params[:product_id])
    current_cart = @current_cart
    if current_cart.products.include?(chosen_product)
      @line_item = current_cart.line_items.find_by(product_id: chosen_product)
      @line_item.quantity += 1
    else
      @line_item = LineItem.new(quantity: 1, product: chosen_product)
      current_cart.line_items << @line_item
    end
    @line_item.order = @order
    @cart = current_cart
    redirect_to products_path, alert: "#{@line_item.product.product_name} added in cart"
  end

  def destroy
    @line_item.destroy
    redirect_to cart_path(@current_cart), alert: "#{@line_item.product.product_name} removed from cart."
  end

  def add_quantity
    @line_item.quantity += 1
    @line_item.save
    redirect_to cart_path(@current_cart)
  end

  def reduce_quantity
    @line_item.quantity -= 1 if @line_item.quantity > 1
    @line_item.save
    redirect_to cart_path(@current_cart)
  end

  private

  def find_line_item
    @line_item = LineItem.find(params[:id])
  end
end
