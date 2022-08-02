module FormHelper
  def submit_button_text(resource)
    resource.new_record? ? "Create" : "Update"
  end

  def user_id_input(resource, f)
    if resource.user.present? && resource.errors.empty?
      capture do
        concat(f.label(:user))
        concat(tag.div(link_to_user(resource.user), class: "mt-1"))
        concat(f.input(:user_id, as: :hidden))
      end
    else
      f.input :user_id, hint: "1234", label: "User ID", required: resource.user_required?
    end
  end

  def checked_html(*args)
    {checked: params.dig(*args) == "1"}
  end
end
