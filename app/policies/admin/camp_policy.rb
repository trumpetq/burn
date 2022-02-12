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

    def destory?
      mayor?
    end

    def approve?
      leader?
    end

    def complete?
      leader?
    end

    def reject?
      leader?
    end
  end
end
