class CampInterviewPolicy < CampPolicy
  def index?
    leader?
  end

  def show?
    (member? && me?) || interviewer? || mayor?
  end

  def approve_or_reject?
    leader? && record.interviewed_by == user
  end

  def interviewer?
    (member? && record.interviewed_by == user)
  end

  def permitted_attributes
    [:action, :index, :feedback_notes, :private_notes]
  end
end
