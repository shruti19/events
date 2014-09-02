class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery #with: :exception
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  
  layout :define_layout

  private

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  
  def after_sign_in_path_for(resource)
    authenticated_user_path
  end

  protected 
  
  def define_layout
    user_signed_in? ? 'authenticated_user' : 'home'
  end
  
  def configure_devise_permitted_parameters
    registration_params = [:first_name, :last_name, :email, :password, :password_confirmation]

    devise_parameter_sanitizer.for(:account_update) { 
      |u| u.permit(registration_params << :current_password)
    }
    devise_parameter_sanitizer.for(:sign_up) { 
      |u| u.permit(registration_params) 
    }
  end

end
