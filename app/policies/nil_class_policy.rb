class NilClassPolicy < ApplicationPolicy
  def show?
    false
  end

  def me?
    false
  end
end
