# frozen_string_literal: true

class CreateStripeCustomer
  def initialize(user)
    @user = user
  end

  def call!
    return nil unless user_attributes_valid?

    create_customer!
  rescue Stripe::StripeError => e
    Rails.logger.error(e.message)
    raise 'An error occurred while saving your account. Please try again!'
  end

  private

  def user_attributes_valid?
    return false unless @user.stripe_customer_id.nil?

    @user = @user.user
    true
  end

  def create_customer!
    customer = Stripe::Customer.create(email: @user.email)
    @user.stripe_customer_id = customer.id
    @user.save!
  end
end
