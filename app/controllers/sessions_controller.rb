def SessionsController < ApplicationController

  def create
    applicant = Applicant.find_by(email: email)
    if applicant && applicant.phone == phone
      log_in applicant
      redirect_to edit_applicant_path(applicant)
    else
      @error = "Incorrect login information."
      redirect_to root_path
    end
  end

  def new
  end

  def logout
    log_out
    redirect_to root_path
  end

  private

  def email
    @email ||= params[:email]
  end

  def phone
    @phone ||= params[:phone]
  end
end
