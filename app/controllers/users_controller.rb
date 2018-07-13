class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new, status:422
    end
  end

  def edit
    @user = current_user
    # render :edit
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :edit 
    end
  end


  def destroy
  end

  private

  def user_params
      params.require(:user).permit(:username, :email, :password)
  end

end
