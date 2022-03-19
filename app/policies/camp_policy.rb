class CampPolicy < ApplicationPolicy
  def index?
    member?
  end

  def show?
    member? && me? || mayor?
  end

  def new?
    member?
  end

  def create?
    member? && me?
  end

  def edit?
    member? && me?
  end

  def update?
    member? && me?
  end

  def me?
    record.user.present? && record.user == user
  end
end
