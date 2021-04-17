# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StripeChargeJob, type: :job do
  describe '#perform' do
    # TODO: Change chargeable_object_id to specific model names as this is just a placeholder.
    let(:chargeable_object_id) { 1 }

    before { StripeChargeJob.perform_now(chargeable_object_id) }

    pending "add some examples to (or delete) #{__FILE__}"
  end
end
