class PagePolicy < ApplicationPolicy
  def contact?
    everyone?
  end

  def home?
    everyone?
  end
end
