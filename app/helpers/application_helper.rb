module ApplicationHelper
  def current_applicant
    @current_applicant ||= Applicant.find_by(email: session[:email])
  end

  def logged_in?
    !current_applicant.nil?
  end
end
