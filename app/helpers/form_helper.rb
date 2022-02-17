module FormHelper
  def submit_button_text(resource)
    resource.new_record? ? "Create" : "Update"
  end
end
