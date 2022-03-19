class CampInterviewMailer < ApplicationMailer
  def assign
    @user = params[:user]
    @interviewed_by = params[:interviewed_by]
    @resource = params[:resource]
    mail(to: @user.email, subject: "Please complete your interview for 8-bit Bunny")
  end

  def approve
    @user = params[:user]
    @interviewed_by = params[:interviewed_by]
    @resource = params[:resource]
    mail(to: @user.email, subject: "Your 8-bit Bunny interview has been approved")
  end

  def new_interview
    @user = params[:user]
    @interviewed_by = params[:interviewed_by]
    @resource = params[:resource]
    mail(to: @interviewed_by.email, subject: "Your have a new interview for 8-bit Bunny")
  end

  def reject
    @user = params[:user]
    @resource = params[:resource]
    mail(to: @user.email, subject: "Your 8-bit Bunny interview has been rejected")
  end
end