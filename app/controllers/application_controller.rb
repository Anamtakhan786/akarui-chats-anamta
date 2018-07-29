class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_users

  def index 
  	 @users = User.all.where.not(id: current_user.id)
  end
  def set_users
    @users = User.all
  end
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :terms_and_conditions, :avatar, :avatar_cache, :remove_avatar])
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :password, :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar, :DOB, :gender, :phone, :bio) }
  end
  
end