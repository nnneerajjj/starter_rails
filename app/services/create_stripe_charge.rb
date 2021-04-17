# frozen_string_literal: true

class ChargeError < RuntimeError; end

# TODO: Change chargeable_object, @customer, @merchant to specific model names as these are just placeholders.
class CreateStripeCharge
  def initialize(chargeable_object)
    @chargeable_object = chargeable_object
    @customer = @chargeable_object.customer
    @merchant = @chargeable_object.other_participant(@customer.user)
  end

  def call
    ensure_chargeable!
    create_charge!
    update_chargeable_object
  rescue Stripe::StripeError => e
    Rails.logger.error("[#{e.class}] ChargeableObject ID: #{@chargeable_object.id} - #{e.message}")
    handle_failed_charge unless e.is_a?(ChargeError)
  end

  private

  def ensure_chargeable!
    raise ChargeError, 'ChargeableObject must be accepted to charge' unless @chargeable_object.accepted?
    raise ChargeError, 'ChargeableObject must be at least 50 cents to charge' unless @chargeable_object.total_cents >= 0
  end

  def create_charge!
    @stripe_charge = Stripe::Charge.create(
        amount: @chargeable_object.total_cents,
        application_fee: (@chargeable_object.total * ENV['COMPANY_FEE_PERCENTAGE']).cents,
        currency: 'usd',
        customer: @customer.stripe_customer_id,
        destination: @merchant.stripe_merchant_account_id
      )
  end

  def update_chargeable_object
    @chargeable_object.update!(:stripe_charge_id, @stripe_charge.id)
  end

  def handle_failed_charge
    @chargeable_object.cancelled!
    send_failure_notifications
  end

  def send_failure_notifications
    merchant = @customer.user
    customer = @merchant.user

    customer_message = I18n.t('push_notifications.customer_charge_failure', merchant_full_name: merchant.full_name)
    merchant_message = I18n.t('push_notifications.merchant_charge_failure', customer_full_name: customer.full_name)

    SendNotifications.new(customer, customer_message).call
    SendNotifications.new(merchant, merchant_message).call
  end
end
