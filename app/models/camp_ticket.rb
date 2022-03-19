# == Schema Information
#
# Table name: camp_tickets
#
#  id         :bigint           not null, primary key
#  location   :integer          not null
#  notes      :text
#  status     :integer          not null
#  type       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_camp_tickets_on_user_id  (user_id)
#
class CampTicket < ApplicationRecord
end
