class ApplicationMailer < ActionMailer::Base
  include Pundit::Authorization

  default from: Settings.email.from
  layout "mailer"
  prepend_view_path(Rails.root.join("app/views/mailers"))

  def current_user # Needed for pundit to work inside mailers
    @resource&.user
  end
end
