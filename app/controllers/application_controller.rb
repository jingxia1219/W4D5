class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  def log_in(user)
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    User.find_by(session_token: session[:session_token])
  end

end
