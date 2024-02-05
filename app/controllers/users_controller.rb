class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # ユーザ登録に成功した場合の処理
      log_in(@user)
      flash[:notice] = t('.created')
      redirect_to user_path(@user.id)
    else
      # ユーザ登録に失敗した場合の処理
      flash.now[:notice] = t('.failed')
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = t('.updated')
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to new_session_path
  end  

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to current_user unless current_user?(@user)
  end
end
