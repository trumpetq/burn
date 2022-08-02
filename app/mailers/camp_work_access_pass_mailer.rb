class CampWorkAccessPassMailer < ApplicationMailer
  def approve
    @resource = params[:resource]
    @user = @resource.user
    mail(to: @user.email, subject: "Your WAP has been approved for 8-bit Bunny")
  end

  def assign
    @resource = params[:resource]
    @user = @resource.user
    mail(to: @user.email, subject: "You have been assigned a WAP for 8-bit Bunny")
  end
end