class UserPolicy < ApplicationPolicy
  def index?
    member?
  end

  def show?
    member? || me?
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

  def permitted_attributes
    [:name, :playa_name, :email, :password, :phone_number, :time_zone, :title, :description, :previous_years, :country_code, :postal_code, :pronouns]
  end
end
