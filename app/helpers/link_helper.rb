module LinkHelper
  def link_to_phone(number, html_options = {})
    return na_badge if number.blank?
    link_to(number.phony_formatted, "tel:#{number}", html_options)
  end

  def link_to_policy(policy, name, options = nil, html_options = {})
    return na_badge if name.blank?
    policy ? link_to(name, options, html_options) : name
  end

  def link_to_id(resource)
    link_to_policy(policy(resource).show?, resource.id, polymorphic_path(resource))
  end

  def admin_link_to_id(resource)
    link_to_policy(policy([:admin, resource]).show?, resource.id, polymorphic_path([:admin, resource]))
  end
end
