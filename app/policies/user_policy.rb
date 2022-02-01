class UserPolicy < ApplicationPolicy
  def index?
    member?
  end

  def show?
    member? || me?
  end

  def me?
    record == user
  end

  def devise?
    everyone?
  end
end
