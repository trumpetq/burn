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
    member? && me? && (Date.current <= Settings.date.job_cutoff_on) && !user.confirmed?
  end

  def sign_up?
    member? && user.can_sign_up_job? && record.try(:can_sign_up?)
  end

  def permitted_attributes
    [:notes]
  end
end
