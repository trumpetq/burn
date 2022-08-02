module Validatable
  extend ActiveSupport::Concern

  def user_exists
    return if user_id.blank?
    errors.add(:user_id, "was not found") unless ::User.exists?(user_id)
  end
end