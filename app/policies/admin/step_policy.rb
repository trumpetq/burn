module Admin
  class StepPolicy < ApplicationPolicy
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
      attrs = [:available_at, :closed_at, :description, :status, :title, :position]
      attrs += [:name, :step_type] if user.mayor?
      attrs
    end
  end
end