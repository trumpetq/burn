module Admin
  class UserStepPolicy < ApplicationPolicy
    def index?
      leader?
    end

    def show?
      leader?
    end

    def new?
      mayor?
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

    def destory?
      mayor?
    end

    def move_higher?
      mayor?
    end

    def move_lower?
      mayor?
    end

    def permitted_attributes
      attrs = [:completed_at, :status]
      attrs += [:stepable_type, :step_id, :stepable_id, :user_id] if user.mayor?
      attrs
    end
  end
end