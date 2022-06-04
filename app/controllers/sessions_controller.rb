class SessionsController < ApplicationController
  before_action :check_login, only: [:edit, :update]
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
  end

  def create
    redirect_if_logged_in
    if !session_params[:name].nil?
      if session_params[:name].is_a?(String) && !session_params[:name].empty?
        session[:name] = session_params[:name]
        redirect_to(:root)
      else
        redirect_to(login_path)
      end
    else
      redirect_to(login_path)
    end
  end

  def destroy
    session.delete(:name)
    redirect_to(:root)
  end

  private

  def session_params
    params.permit(:name)
  end

  def check_login
    if !logged_in?
      flash[:alert] = "Please log in!"
      redirect_to(login_path)
    end
  end

  def redirect_if_logged_in
    return redirect_to(:root) if logged_in?
  end

end