class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def print_errors(errors)
    error = errors.first
    error[0].to_s.split("_").join(" ").capitalize + " #{error[1]}"
  end

  def permitted
    params.require(controller_name.singularize.to_sym).permit permitted_params
  end
end
