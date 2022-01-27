class ErrorPolicy < ApplicationPolicy
  def forbidden?
    everyone?
  end

  def internal_server_error?
    everyone?
  end

  def not_acceptable?
    everyone?
  end

  def not_found?
    everyone?
  end

  def unauthorized?
    everyone?
  end

  def unprocessable_entity?
    everyone?
  end
end
