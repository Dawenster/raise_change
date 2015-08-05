class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  helper_method :amounts_to_donate, :donation_period, :has_credit_card?, :can_create_journal_entries?

  def after_sign_in_path_for(resource)
    user_path(resource) || root_path
  end

  def amounts_to_donate
    # return ["$0.25", "$0.50", "$1.00"]
    return ["$0.25"]
  end

  def donation_period
    "quarterly"
  end

  def has_credit_card?
    user_signed_in? && current_user.has_credit_cards?
  end

  def can_create_journal_entries?
    user_signed_in? && current_user.campaigns.any?
  end

  def authenticate_admin_user!
    unless current_user.try(:admin?)
      flash[:alert] = "You are not authorized to access this page."
      redirect_to root_path
    end
  end

  def create_and_sign_in_user
    user = User.find_by_email(params[:email])
    if user
      sign_in(:user, user)
      return user
    else
      user = User.new(
        :first_name => params[:first_name],
        :last_name => params[:last_name],
        :email => params[:email],
        :password => params[:password]
      )
      user.skip_confirmation!
      if user.save
        sign_in(:user, user)
        return user
      else
        flash.now[:alert] = user.errors.full_messages.join(". ") + "."
        redirect_to request.referrer || root_path and return
      end
    end
  end

  protected

  def configure_devise_permitted_parameters
    registration_params = [:first_name, :last_name, :avatar, :email, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(registration_params << :current_password, :avatar)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(registration_params) 
      }
    end
  end
end
