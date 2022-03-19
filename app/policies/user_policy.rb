class UserPolicy < ApplicationPolicy
  def index?
    member?
  end

  def show?
    member? || me?
  end

  def edit?
    me?
  end

  def admin?
    leader?
  end

  def camp?
    leader?
  end

  def devise?
    everyone?
  end

  def me?
    record == user
  end

  def contact?
    member?
  end

  def permitted_attributes
    [:name, :playa_name, :email, :password, :phone_number, :time_zone, :title, :description, :country_code, :postal_code, :pronouns, :facebook_url, :instagram_url, :twitter_url, :plan, :avatar, previous_years: []]
  end
end
