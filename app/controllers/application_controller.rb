class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery #with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json
  helper_method :current_user_json

  def current_user_json
    if current_user
      UserSerializer.new(current_user, scope: current_user, root: false).to_json
    else
      {}.to_json
    end
  end

  # before_filter :update_sanitized_params, if: :devise_controller?

  # def update_sanitized_params
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
  # end
end
