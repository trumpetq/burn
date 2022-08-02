class CampJobPolicy < CampPolicy
  def destroy?
    false
  end

  def edit?
    member? && me? && user.can_sign_up_job?
  end

  def update?
    member? && me? && user.can_sign_up_job?
  end

  def sign_up?
    member? && user.can_sign_up_job? && record.try(:can_sign_up?)
  end

  def permitted_attributes
    [:notes]
  end
end
