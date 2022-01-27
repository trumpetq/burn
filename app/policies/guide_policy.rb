class GuidePolicy < ApplicationPolicy
  def index?
    everyone?
  end

  def power?
    everyone?
  end

  def shipping_container?
    everyone?
  end
end
