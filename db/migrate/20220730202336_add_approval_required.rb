class AddApprovalRequired < ActiveRecord::Migration[7.0]
  def change
    add_column :camp_work_access_passes, :approval_required, :boolean, null: true
  end
end
