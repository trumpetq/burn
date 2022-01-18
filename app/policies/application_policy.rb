# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end

  protected

  def user?
    user.present?
  end

  def mayor?
    return false unless user?

    user.mayor?
  end

  def leader?
    return false unless user?

    user.leader? || mayor?
  end

  def camper?
    return false unless user?

    user.camper? || leader?
  end

  def member?
    return false unless user?

    user.member? || camper?
  end

  def guest?
    return false unless user?

    user.guest? || member?
  end
end
