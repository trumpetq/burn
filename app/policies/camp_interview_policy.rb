class CampInterviewPolicy < CampPolicy
  def approve?
    member? && record.interviewed_by.present? && record.interviewed_by == user
  end

  def reject?
    member? && record.interviewed_by.present? && record.interviewed_by == user
  end

  def permitted_attributes
    [:feedback_notes, :private_notes]
  end
end
