module Roleable
  extend ActiveSupport::Concern

  def leader_or_above?
    leader? || mayor?
  end

  def member_or_above?
    member || leader? || mayor?
  end
end