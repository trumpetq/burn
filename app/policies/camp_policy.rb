class CampPolicy < ApplicationPolicy
  def index?
    member?
  end

  def show?
    (member? && me?) || leader?
  end

  def new?
    member?
  end

  def create?
    member? && me?
  end

  def edit?
    member? && me? && !finished?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def admin?
    leader?
  end

  def me?
    record.user.present? && record.user == user
  end

  def finished?
    record.finished?
  end
end
