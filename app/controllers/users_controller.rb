class UsersController < ApplicationController
  # GET /users/new
  def new
    @user = User.new
  end
  
  # POST /users (+ params)
  def create
    @user = User.new(user_params)
    if @user.save
      # GET "users/#{@user.id}"
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      # redirect_to user_path(@user)
      # redirect_to user_path(@user.id)
      # redirect_to user_path(1)
                   # => users/1
    else
      render 'new'
    end
  end
  
  # GET /users/:id
  def show
    # ローカル変数：このアクションの中でしか使えない
    # @user
    # インスタンス変数：もう少し外、viewで使える
    @user = User.find(params[:id])
    # グローバル変数：まず使わない
    # @@user
  end
  
  private
  # この後ろに書いたものは、外部からアクセスできない
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end
  
end
