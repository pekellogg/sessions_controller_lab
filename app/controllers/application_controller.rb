class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  helper_method :current_user_name, :logged_in?

  def logged_in?
    session[:name] ? true : false
  end

  def current_user_name
    session[:name]
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render(json: {error: exception.message}, status: :bad_request)
  end

end