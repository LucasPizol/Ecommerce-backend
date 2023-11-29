class PaymentsController < ApplicationController
  #before_action :authorize

  def create
    params = products_params[:products].as_json

    products = Stripe::Checkout::Session.create({
      success_url: "https://www.google.com",
      line_items: params,
      mode: "payment"
    })

    render json: {url:products[:url]}, status: :ok

  end


  def products_params
    params.permit(products: [:price, :quantity, price_data: [:currency, :unit_amount, product_data: [:name] ]])
  end
end
