# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  first_name             :string
#  last_name              :string
#  email                  :string
#  role                   :string           default("user"), not null
#  status                 :integer          default("active"), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  include Authorizable
  include UserAdmin

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable,
         :validatable, :token_authenticatable, :encryptable # , :confirmable, :omniauthable

  enum role: { admin: 'admin', user: 'user' }
  enum status: %i[pending active inactive]

  validates :first_name, :last_name, :role, :status, presence: true

  has_many :authentication_tokens, dependent: :destroy
  has_many :installations, dependent: :destroy

  before_save :destroy_auth_tokens, if: :encrypted_password_changed?

  has_one_attached :profile_picture

  def full_name
    "#{first_name} #{last_name}"
  end

  def password_salt
    'no salt'
  end

  def password_salt=(new_salt); end

  def tokens
    authentication_tokens.pluck(:body)
  end

  private

  def destroy_auth_tokens
    authentication_tokens.destroy_all
  end
end
