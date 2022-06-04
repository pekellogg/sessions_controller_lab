class SessionsController < ApplicationController
  before_action :check_login, only: [:edit, :update]

  def new
  end

  def create
    if !logged_in?
      if !session_params[:name].nil?
        if session_params[:name].is_a?(String) && !session_params[:name].empty?
          session[:name] = session_params[:name]
          redirect_to("/")
        else
          redirect_to(:login)
        end
      else
        redirect_to(:login)
      end
    else
      flash[:alert] = "Please log out before creating a new account!"
      redirect_to(:login)
    end
  end

  def login
    render(:new)
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
      redirect_to(:login)
    end
  end

end