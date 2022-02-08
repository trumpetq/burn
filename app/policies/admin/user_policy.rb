module Admin
  class UserPolicy < ApplicationPolicy
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

    def destroy?
      mayor?
    end

    def me?
      record == user
    end

    def permitted_attributes
      attrs = [:name, :playa_name, :email, :password, :phone_number, :time_zone, :title, :description, :previous_years, :country_code, :postal_code, :pronouns, :facebook_url, :instagram_url, :twitter_url]
      attrs += [:role, :status] if user.mayor?
      attrs
    end
  end
end