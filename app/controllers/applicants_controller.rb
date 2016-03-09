class ApplicantsController < ApplicationController
  before_action :require_login, only: [:edit, :background, :authorize, :confirm]
  before_action :check_authorization, only: [:background, :authorize]

  def index
  end

  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(permitted)
    if @applicant.save
      log_in @applicant
      redirect_to background_applicants_path
    else
      render register_path
    end
  end

  def update
    @applicant = current_applicant
    if @applicant.update(permitted)
      log_in @applicant
      redirect_to edit_applicant_path(current_applicant)
    else
      render "edit"
    end
  end

  def edit
    @applicant = current_applicant
  end

  def background
  end

  def confirm
  end

  def authorize
    current_applicant.update_state
    redirect_to comfirm_applicants_path
  end

  private

  def check_authorization
    if current_applicant.workflow_state == "background_check_authorized"
      redirect_to confirm_applicants_path
    end
  end

  def require_login
    !@current_user.nil?
  end

  def permitted_params
    [:email, :first_name, :last_name, :phone, :phone_type, :region]
  end
end
