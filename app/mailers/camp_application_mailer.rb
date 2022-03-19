class CampApplicationMailer < ApplicationMailer
  def approve
    @user = params[:user]
    @resource = params[:resource]
    mail(to: @user.email, subject: "Your 8-bit Bunny application has been approved")
  end

  def complete
    @user = params[:user]
    @resource = params[:resource]
    mail(to: @user.email, subject: "Your 8-bit Bunny application has been completed")
  end

  def reject
    @user = params[:user]
    @resource = params[:resource]
    mail(to: @user.email, subject: "Your 8-bit Bunny application has been rejected")
  end
end