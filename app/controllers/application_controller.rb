class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
  	# Session ID has been set in LOGIN method
  	User.find(session[:id]) if session[:id]
  end
  helper_method :current_user

end
