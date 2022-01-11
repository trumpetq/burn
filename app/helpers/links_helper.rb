module LinksHelper
  def link_to_phone(number, html_options = {})
    link_to(number.phony_formatted, "tel:#{number}", html_options)
  end
end
