module ResourceHelper
  def header_admin_new_button(resource)
    return unless resource.present?
    if policy([:admin, resource]).new?
      link_to(bootstrap_icon("plus-circle-fill"), new_polymorphic_path([:admin, resource]), class: "float-end btn btn-xs btn-outline-primary")
    end
  end

  def header_admin_edit_button(resource)
    return unless resource.present?
    if policy([:admin, resource]).edit?
      link_to(bootstrap_icon("pencil-fill"), edit_polymorphic_path([:admin, resource]), class: "float-end btn btn-xs btn-outline-primary")
    end
  end

  def header_admin_delete_button(resource)
    if policy([:admin, resource]).destroy?
      link_to(bootstrap_icon("trash-fill"), [:admin, resource], data: {turbo_confirm: "Are you sure?", turbo_method: :delete}, class: "float-end btn btn-xs btn-outline-danger")
    end
  end

  def header_edit_button(resource)
    return unless resource.present?
    if policy(resource).edit?
      link_to("Edit", edit_polymorphic_path(resource), class: "float-end btn btn-xs btn-outline-primary")
    end
  end
end