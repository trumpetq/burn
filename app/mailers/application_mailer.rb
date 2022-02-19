class ApplicationMailer < ActionMailer::Base
  default from: Settings.email.contact
  layout "mailer"
  prepend_view_path(Rails.root.join("app/views/mailers"))
end
