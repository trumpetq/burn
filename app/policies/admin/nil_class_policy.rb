module Admin
  class NilClassPolicy < ApplicationPolicy
    def index?
      false?
    end

    def show?
      false
    end

    def edit?
      false
    end

    def create?
      false
    end

    def update?
      false
    end

    def destroy?
      false
    end
  end
end
