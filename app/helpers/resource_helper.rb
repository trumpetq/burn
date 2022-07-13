module ResourceHelper
  def header_admin_show_button(resource)
    return unless resource.present?
    if policy([:admin, resource]).show?
      link_to(bootstrap_icon("back"), polymorphic_path([:admin, resource]), class: "btn btn-xs btn-outline-secondary", target: "_blank")
    end
  end

  def header_admin_new_button(resource, options = {})
    return unless resource.present?
    if policy([:admin, resource]).new?
      link_to(bootstrap_icon("plus-circle-fill"), new_polymorphic_path([:admin, resource], options), class: "btn btn-xs btn-outline-primary")
    end
  end

  def header_admin_edit_button(resource)
    return unless resource.present?
    if policy([:admin, resource]).edit?
      link_to(bootstrap_icon("pencil-fill"), edit_polymorphic_path([:admin, resource]), class: "btn btn-xs btn-outline-primary")
    end
  end

  def header_admin_delete_button(resource)
    if policy([:admin, resource]).destroy? && !resource.try(:discarded?)
      return link_to(bootstrap_icon("trash-fill"), [:admin, resource], data: {turbo_confirm: "Are you sure?", turbo_method: :delete}, class: "btn btn-xs btn-outline-danger")
    end

    if policy([:admin, resource]).try(:restore?) && resource.try(:discarded?)
      link_to(bootstrap_icon("unlock-fill"), polymorphic_path([:admin, resource], action: :restore), data: {turbo_confirm: "Are you sure?", turbo_method: :patch}, class: "btn btn-xs btn-outline-warning")
    end
  end

  def header_show_button(resource)
    return unless resource.present?
    if policy(resource).show?
      link_to(bootstrap_icon("back"), polymorphic_path(resource), class: "btn btn-xs btn-outline-secondary", target: "_blank")
    end
  end

  def header_new_button(resource, options = {})
    return unless resource.present?
    if policy(resource).new?
      link_to(bootstrap_icon("plus-circle-fill"), new_polymorphic_path(resource, options), class: "btn btn-xs btn-outline-primary")
    end
  end

  def header_edit_button(resource)
    return unless resource.present?
    if policy(resource).edit?
      link_to(bootstrap_icon("pencil-fill"), edit_polymorphic_path(resource), class: "btn btn-xs btn-outline-primary")
    end
  end

  def header_delete_button(resource)
    if policy(resource).destroy? && !resource.try(:discarded?)
      link_to(bootstrap_icon("trash-fill"), resource, data: {turbo_confirm: "Are you sure?", turbo_method: :delete}, class: "btn btn-xs btn-outline-danger")
    end
  end
end