class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def permitted
    params.require(controller_name.singularize.to_sym).permit permitted_params
  end
end
