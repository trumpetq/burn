module IconHelper
  def link_icon(resource)
    return unless policy(resource).show?
    link_to(bootstrap_icon("link"), polymorphic_path(resource))
  end

  def admin_link_icon(resource)
    return unless policy([:admin, resource]).show?
    link_to(bootstrap_icon("link"), polymorphic_path([:admin, resource]))
  end

  def edit_icon(resource)
    return unless policy(resource).edit?
    link_to(bootstrap_icon("pencil"), edit_polymorphic_path(resource))
  end

  def admin_edit_icon(resource)
    return unless policy([:admin, resource]).edit?
    link_to(bootstrap_icon("pencil"), edit_polymorphic_path([:admin, resource]))
  end

  def new_icon(resource, options = {})
    return unless policy(resource).new?
    link_to(bootstrap_icon("plus-circle-fill"), new_polymorphic_path(resource, options))
  end

  def admin_new_icon(resource, options = {})
    return unless policy([:admin, resource]).new?
    link_to(bootstrap_icon("plus-circle-fill"), new_polymorphic_path([:admin, resource], options))
  end
end

