class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :check_first_launch
  protect_from_forgery with: :exception
  skip_before_filter  :verify_authenticity_token
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:email, :password] #add or remove parameters as needed
  end

  def check_first_launch
    if current_user
      if session[:first_launch].nil?
        session[:first_launch] = 1
      else
        session[:first_launch] = session[:first_launch] + 1
      end
    else
      session[:first_launch] = nil
    end

  end
end
