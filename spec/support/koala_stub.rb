# frozen_string_literal: true

module KoalaStub
  def stub_koala_client!
    setup_facebook_user!
  end

  def stub_koala_client_with_error!
    setup_api_error!
  end

  # Can be overridden in specs by merging into hash prior to calling methods above
  def facebook_attributes
    facebook_default_attributes
  end

  private

  def facebook_default_attributes
    {
        'id' => 'fake_uid',
        'first_name' => 'First',
        'last_name' => 'Last',
        'email' => 'test@gmail.com'
    }
  end

  def setup_facebook_user!
    client = double('koala facebook api', get_object: facebook_attributes) # rubocop:disable RSpec/VerifiedDoubles
    allow(Koala::Facebook::API).to receive(:new).and_return(client)
  end

  def setup_api_error!
    allow(Koala::Facebook::API).to receive(:new).and_return(Koala::Facebook::APIError)
  end
end
