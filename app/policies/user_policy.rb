class UserPolicy < ApplicationPolicy
  def index?
    member?
  end

  def show?
    member? || me?
  end

  def new?
    mayor?
  end

  def create?
    new?
  end

  def edit?
    member?
  end

  def update?
    edit?
  end

  def destory?
    mayor?
  end

  def me?
    record == user
  end

  def devise?
    everyone?
  end

  def permitted_attributes
    attrs = [:name, :playa_name, :phone_number, :time_zone]
    attrs += [:role_enum, :status_enum] if user.mayor?
    attrs
  end
end
