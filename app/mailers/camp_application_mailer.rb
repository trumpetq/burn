class CampApplicationMailer < ApplicationMailer
  def approve_email
    @user = params[:user]
    mail(to: @user.email, subject: "Your 8-bit Bunny application has been approved")
  end

  def complete_email
    @user = params[:user]
    mail(to: @user.email, subject: "Your 8-bit Bunny application has been completed")
  end

  def reject_email
    @user = params[:user]
    mail(to: @user.email, subject: "Your 8-bit Bunny application has been rejected")
  end
end