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

  def confirm?
    member? && me?
  end

  def contact?
    member?
  end

  def devise?
    everyone?
  end

  def me?
    record.present? && record == user
  end

  def status?
    member?
  end

  def ticket?
    member? && me? && user.confirmed?
  end

  def permitted_attributes
    [:born_on, :allergies, :diet, :name, :playa_name, :email, :password, :phone_number, :time_zone, :title, :description, :country_code, :postal_code, :pronouns, :facebook_url, :instagram_url, :tiktok_url, :twitter_url, :plan, :avatar, previous_years: []]
  end
end
