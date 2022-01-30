module Admin
  class PagePolicy < ApplicationPolicy
    def home?
      leader?
    end

    def system?
      leader?
    end
  end
end