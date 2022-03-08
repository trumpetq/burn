class CampInterviewPolicy < CampPolicy
  def permitted_attributes
    [:feedback_notes, :initial_notes, :private_notes]
  end
end
