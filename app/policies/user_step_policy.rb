class UserStepPolicy < ApplicationPolicy
  def index?
    member?
  end

  def show?
    member? && me?
  end

  def edit?
    member && me?
  end

  def update?
    edit?
  end

  def me?
    record.user == user
  end

  def permitted_attributes
    []
  end
end
