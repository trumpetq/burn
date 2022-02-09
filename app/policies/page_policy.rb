class PagePolicy < ApplicationPolicy
  def contact?
    everyone?
  end

  def events?
    everyone?
  end

  def history?
    everyone?
  end

  def home?
    everyone?
  end
end
