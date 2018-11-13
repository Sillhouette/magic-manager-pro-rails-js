class UsersController < ApplicationController
  def index

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    return redirect_to controller: 'users', action: 'new' unless @user.save
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

  def show
    if logged_in?
      @user = User.find_by(id: params[:id])
      @card = UserCard.new
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @user}
      end
    else
      redirect_to root_url
    end
  end

  # def update
  #   @user = User.find(params[:id])
  #   if @user.update(user_params)
  #     redirect_to user_path
  #   else
  #     render :edit
  #   end
  # end
  #
  # def edit
  #   @user = User.find_by(id: params[:id])
  # end

  def update

  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :dci_number)
  end
end
