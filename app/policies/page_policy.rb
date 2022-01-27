class PagePolicy < ApplicationPolicy
  def home?
    everyone?
  end

  def system?
    mayor? || leader?
  end
end
