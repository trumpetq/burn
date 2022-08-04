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
    member? && user.can_sign_up_wap? && record.try(:can_sign_up?)
  end
  def permitted_attributes
    [:expected_arrival_on, :notes]
  end
end
