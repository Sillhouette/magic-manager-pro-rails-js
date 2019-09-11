class WelcomeController < ApplicationController
  def index
    if logged_in?
      redirect_to user_path(@user)
    end
  end
end
