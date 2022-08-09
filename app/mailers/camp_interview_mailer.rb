class CampInterviewMailer < ApplicationMailer
  def assign
    @resource = params[:resource]
    mail(to: @resource.user.email, subject: "Please complete your interview for 8-bit Bunny")
  end

  def approve
    @resource = params[:resource]
    mail(to: @resource.user.email, subject: "Your 8-bit Bunny interview has been approved")
  end

  def admin_approve
    @resource = params[:resource]
    mail(to: Settings.email.david, subject: "#{@resource.user} interview has been approved")
  end

  def skip
    @resource = params[:resource]
    mail(to: @resource.user.email, subject: "You have skipped the interview step for 8-bit Bunny")
  end

  def new_interview
    @resource = params[:resource]
    mail(to: @resource.interviewed_by.email, subject: "You have a new interview for 8-bit Bunny")
  end

  def no_response
    @resource = params[:resource]
    mail(to: @resource.user.email, subject: "We haven't heard back about your interview for 8-bit Bunny")
  end

  def reassign
    @resource = params[:resource]
    mail(to: @resource.user.email, subject: "Your interview with 8-bit Bunny has been reassigned")
  end

  def reject
    @resource = params[:resource]
    mail(to: @resource.user.email, subject: "Your 8-bit Bunny interview has been rejected")
  end

  def admin_reject
    @resource = params[:resource]
    mail(to: Settings.email.david, subject: "#{@resource.user} interview has been rejected")
  end
end
