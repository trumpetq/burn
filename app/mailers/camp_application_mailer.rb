class CampApplicationMailer < ApplicationMailer
  def admin_apply
    @resource = params[:resource]
    @user = @resource.user
    mail(to: Settings.email.david, subject: "A new user has applied to 8-bit Bunny")
  end

  def approve
    @resource = params[:resource]
    @user = @resource.user
    mail(to: @user.email, subject: "Your 8-bit Bunny application has been approved")
  end

  def complete
    @resource = params[:resource]
    @user = @resource.user
    mail(to: @user.email, subject: "Your 8-bit Bunny application has been completed")
  end

  def reject
    @resource = params[:resource]
    @user = @resource.user
    mail(to: @user.email, subject: "Your 8-bit Bunny application has been rejected")
  end
end