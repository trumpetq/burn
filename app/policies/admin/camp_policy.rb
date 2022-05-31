module Admin
  class CampPolicy < ApplicationPolicy
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

    def destroy?
      mayor?
    end

    def active?
      mayor?
    end

    def approve?
      leader?
    end

    def complete?
      leader?
    end

    def force_delete?
      mayor?
    end

    def pay?
      mayor?
    end

    def restore?
      mayor?
    end

    def reject?
      leader?
    end

    def skip?
      leader?
    end
  end
end
