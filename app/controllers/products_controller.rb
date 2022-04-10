class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_product, except: [:index, :show, :new, :create]

  def index
    @products = Product.all
  end

  # no specific product displayed, root path displays all products
  def show
    redirect_to root_path
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save!
      redirect_to root_path, alert: "New Product '#{@product.product_name}' added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product, alert: 'Product Updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:product_name, :description,:image, :price)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
