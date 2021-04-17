# frozen_string_literal: true

# TODO: Change chargeable_object to specific model names as this is just a placeholder.

class StripeChargeJob < ApplicationJob
  queue_as :default

  def perform(chargeable_object_id)
    # chargeable_object = ChargeableObject.find(chargeable_object_id)
    # CreateStripeCharge.new(chargeable_object).call
  end
end
