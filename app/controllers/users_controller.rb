class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(first_name: user_params[:first_name],
                    last_name: user_params[:last_name],
                    email: user_params[:email].downcase,
                    password: user_params[:password],
                    password_confirmation: user_params[:password_confirmation])
    if @user.save
      session[:user_id] = user.id
      redirect_to root_path
    else
      render new_user_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
