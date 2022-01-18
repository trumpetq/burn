class PagePolicy < ApplicationPolicy
  def home?
    true
  end

  def system?
    true
  end
end