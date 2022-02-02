class StepPolicy < ApplicationPolicy
  def index?
    member?
  end

  def show?
    member?
  end
end
