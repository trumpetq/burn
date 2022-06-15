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

  def link_to_camp(name, resource = nil, html_options = {})
    unless name.is_a?(String)
      html_options = resource
      resource = name
      name = resource.to_s
    end

    link_to_policy(policy(resource).show?, name, polymorphic_path(resource), html_options)
  end

  def admin_link_to_camp(name, resource = nil, html_options = {})
    unless name.is_a?(String)
      html_options = resource
      resource = name
      name = resource.to_s
    end

    link_to_policy(policy([:admin, resource]).show?, name, polymorphic_path([:admin, resource]), html_options)
  end

  def link_to_user(user)
    return na_badge if user.blank?
    link_to_policy(policy(user).show?, user, user_path(user))
  end

  def admin_link_to_user(user)
    return na_badge if user.blank?
    link_to_policy(policy([:admin, user]).show?, user, admin_user_path(user))
  end

  def link_to_guide(text, page)
    link_to_policy(policy(:guide).send("#{page}?"), text, polymorphic_path([page, :guides]))
  end
end
