class CampJobPolicy < CampPolicy
  def show?
    member?
  end

  def edit?
    member? && me? && user.can_sign_up_job?
  end

  def update?
    member? && me? && user.can_sign_up_job?
  end

  def destroy?
    false
  end

  def remove?
    member? && me? && (Date.current <= Settings.camp.cutoff_date)
  end

  def sign_up?
    member? && user.can_sign_up_job? && record.try(:can_sign_up?)
  end

  def permitted_attributes
    [:notes]
  end
end
