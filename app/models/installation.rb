# frozen_string_literal: true

# == Schema Information
#
# Table name: installations
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_installations_on_user_id            (user_id)
#  index_installations_on_user_id_and_token  (user_id,token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Installation < ApplicationRecord
  belongs_to :user

  validates :token, presence: true
  validates :token, uniqueness: { scope: :user_id }
end
