class CampInterviewPolicy < CampPolicy
  def show?
    (member? && me?) || (member? && record.interviewed_by == user) || mayor?
  end

  def approve_or_reject?
    member? && record.interviewed_by == user
  end

  def permitted_attributes
    [:action, :index, :feedback_notes, :private_notes]
  end
end
