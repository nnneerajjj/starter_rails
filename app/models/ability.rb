# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    global_ability

    return unless user

    if user.admin?
      admin_ability
    elsif user.user?
      user_ability user
    end
  end

  private

  def global_ability
    can :create, ContactMessage
    can :index, Page
  end

  def admin_ability
    can :manage, :all
    can :access, :rails_admin # grant access to rails_admin
    can :dashboard, :all # grant access to the dashboard
    cannot :create, User
  end

  def user_ability(user)
    can :create, Installation
    can :read, Installation, user_id: user.id
    # can :ephemeral_key, :stripe # TODO If User is a customer
    # can :auth_url, :stripe # TODO If User is a sub merchant
  end
end
