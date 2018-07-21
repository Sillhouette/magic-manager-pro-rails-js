class SessionsController < ApplicationController
  def new
  end

  def create
     binding.pry
    # if auth['uid']
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.name = auth['info']['name']
        u.email = auth['info']['email']
        u.image = auth['info']['image']
      end
      session[:user_id] = @user.id
    # else
    #   user = User.find_by(name: params[:user][:name])
    #   user = user.try(:authenticate, params[:user][:password])
    #   return redirect_to(controller: 'sessions', action: 'new') unless user
    #   session[:user_id] = user.id
    #   @user = user
    # end
    redirect_to user_path(@user)
  end

  def destroy
    session.delete :user_id
    redirect_to '/'
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
