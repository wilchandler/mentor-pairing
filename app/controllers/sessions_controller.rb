class SessionsController < ApplicationController

  def new
    redirect_to '/auth/dbc'
  end

  def create
    user = Authentication.new(auth_hash).user
    if user.persisted?
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to :back
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth'].info
  end
end
