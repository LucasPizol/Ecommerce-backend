module StripeService
  module_function

  def create_checkout_session(user, product, sucess_url:, cancel_url:)
    sessions = Stripe::Checkout::Session.create({
      sucess_url: success_url,
      cancel_url: cancel_url,
      payment_method_types: ["card"],
      client_reference_id: product.id,
      allow_promotion_codes: false,
      mode:"payment",
      line_items: [
        {
          price_data: {
            currency: "gbp",
            unit_amount: product.amount_in_cents,
            product_data: {
              name: product.name,
              description: product.description,
              metadata: {
                userId: user.id,
                productId: product.id
              }
            }
          }
          quantity: 1
        }
      ]
    })

    StripeServiceResponse.new(
      status: "ok",
      error:nil,
      url: session.url
    )

  rescue => e
    StripeServiceResponse.new(
      status: "error",
      error: e.message
    )
  end

  class StripeServiceResponse < Struct.new(:status, :error, :url, keyword_init: true)
    def success?
      status == "ok"
    end
  end
end
