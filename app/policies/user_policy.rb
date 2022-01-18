class UserPolicy < ApplicationPolicy
  def show?
    member?
  end

  def me?
    record == user
  end

  def devise?
    true
  end
end