module ApplicationHelper
  def current_applicant
    @current_applicant ||= Applicant.find_by(email: session[:email])
  end

  def logged_in?
    !current_applicant.nil?
  end

  def log_in(user)
    session[:email] = user.email
  end

  def log_out
    session[:email] = nil
  end
end
