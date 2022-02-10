class NewsletterPolicy < ApplicationPolicy
  def index?
    everyone?
  end

  def show?
    member? && me?
  end

  def new?
    everyone?
  end

  def create?
    new?
  end

  def edit?
    member? && me?
  end

  def update?
    member? && me?
  end

  def destroy?
    member? && me?
  end

  def me?
    record.user.present? && record.user == user
  end

  def unsubscribe?
    member? && me?
  end

  def permitted_attributes
    [:email, :unsubscribe_token]
  end
end