# frozen_string_literal: true

class RetrieveDefaultPaymentMethod
  def initialize(user)
    @user = user
  end

  def call
    @stripe_customer = stripe_customer
    return if @stripe_customer.nil?

    default_payment_method
  rescue Stripe::StripeError => e
    Rails.logger.error(e.message)
    nil
  end

  private

  def stripe_customer
    return if @user.stripe_customer_id.nil?

    @stripe_customer = Stripe::Customer.retrieve(@user.stripe_customer_id)
  end

  def default_payment_method
    default = @stripe_customer[:sources].find { |source| source.id == @stripe_customer[:default_source] }
    return if default.nil?

    "#{default[:brand]} #{default[:last4]}"
  end
end
