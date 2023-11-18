class ProductsController < ApplicationController
  def show
    products = Stripe::Product.list().select{|product| product[:active]}
    prices = Stripe::Price.list()
    products.map {
      |product|
        prices.map {
          |price|

          if (price.id == product.default_price)
            product.default_price = price
          end
        }
  }

    render json: {products:products}, status: :ok
  end

  def create
  end

  def product_params
    params.permit(:name)
  end
end
