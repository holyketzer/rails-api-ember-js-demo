class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery

  respond_to :html, :json
  helper_method :current_user_json

  def current_user_json
    if current_user
      UserSerializer.new(current_user, scope: current_user, root: false).to_json
    else
      {}.to_json
    end
  end
end
