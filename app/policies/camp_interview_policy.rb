class CampInterviewPolicy < CampPolicy
  def approve_or_reject?
    member? && record.interviewed_by == user
  end

  def admin?
    leader?
  end

  def permitted_attributes
    [:action, :index, :feedback_notes, :private_notes]
  end
end
