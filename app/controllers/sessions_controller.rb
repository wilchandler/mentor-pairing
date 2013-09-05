class SessionsController < ApplicationController

  def new
    redirect_to '/auth/dbc'
  end

  def create
    @user = User.find_or_create_by_dbc_id(auth_hash['id'])
    session[:user_id] = @user.id
    redirect_to root_path
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
