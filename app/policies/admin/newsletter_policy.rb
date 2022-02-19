module Admin
  class NewsletterPolicy < ApplicationPolicy
    def index?
      leader?
    end

    def show?
      leader?
    end

    def new?
      leader?
    end

    def create?
      new?
    end

    def edit?
      leader?
    end

    def update?
      edit?
    end

    def destroy?
      mayor?
    end

    def me?
      record.user.present? && record.user == user
    end

    def restore?
      mayor?
    end

    def force_delete?
      mayor?
    end

    def unsubscribe?
      leader?
    end

    def export?
      mayor?
    end

    def permitted_attributes
      attrs = [:email, :list]
      attrs += [:user_id] if user.mayor?
      attrs
    end
  end
end
