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

    def deleted?
      mayor?
    end

    def interviewers?
      leader?
    end

    def me?
      record.present? && record == user
    end

    def restore?
      mayor?
    end

    def remove_avatar?
      mayor?
    end

    def permitted_attributes
      attrs = [:name, :playa_name, :email, :password, :phone_number, :time_zone, :title, :description, :country_code, :postal_code, :private_notes, :pronouns, :facebook_url, :instagram_url, :tiktok_url, :twitter_url, :plan, :avatar, previous_years: []]
      attrs += [:role, :status] if user.mayor?
      attrs
    end
  end
end