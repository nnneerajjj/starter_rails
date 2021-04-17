# frozen_string_literal: true

# == Schema Information
#
# Table name: pages
#
#  id          :bigint(8)        not null, primary key
#  title       :string
#  description :text
#  user_id     :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_pages_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Page < ApplicationRecord
  belongs_to :user

  validates :title, length: { maximum: 255 }
  validates :description, length: { maximum: 1000 }
end
