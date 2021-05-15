class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  # GET /users
  def index
    # 複数形
    @users = User.paginate(page: params[:page])
  end
  
  # メソッドを呼び出すときはシンボルを使う
  # GET /users/new
  def new
    @user = User.new
  end
  
  # POST /users (+ params)
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
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
  
  # GET users/:id/edit
  def edit
    @user = User.find(params[:id])
    # デフォルトのview(app/views/users/edit.html.)が呼び出される
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      # @user.errorsにエラーが格納されている
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  private
  # この後ろに書いたものは、外部からアクセスできない
  
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end
  
  # ログイン済みユーザーかどうか確認
  def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
  end
    
  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
    # redirect_to(root_url) unless @user == current_user
  end  
  
  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
end
