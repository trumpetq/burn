class CampWorkAccessPassPolicy < CampPolicy
  def show?
    member?
  end

  def edit?
    member? && me? && user.can_sign_up_wap?
  end

  def update?
    member? && me? && user.can_sign_up_wap?
  end

  def destroy?
    false
  end

  def sign_up?
    if record.valid?
      member? && user.can_sign_up_wap? && record.try(:can_sign_up?)
    else
      member? && me? && user.can_sign_up_wap? && record.assigned?
    end
  end

  def permitted_attributes
    [:expected_arrival_on, :notes]
  end
end
