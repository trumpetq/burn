module FormHelper
  def submit_button_text(resource)
    resource.new_record? ? "Create" : "Edit"
  end
end
