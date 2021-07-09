class UsersController < ApplicationController
  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.email}!"
      redirect_to "/dashboard"
    else
      flash[:error] = "Invalid Credentials"
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    user = user_params
    user[:email] = user[:email].downcase
    new_user = User.create(user)
    if new_user.save
        session[:user_id] = new_user.id
        flash[:success] = "Welcome, #{new_user.email}!"
    end
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
