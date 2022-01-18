class ErrorPolicy < ApplicationPolicy
  def forbidden?
    true
  end

  def internal_server_error?
    true
  end

  def not_acceptable?
    true
  end

  def not_found?
    true
  end

  def unauthorized?
    true
  end

  def unprocessable_entity?
    true
  end
end