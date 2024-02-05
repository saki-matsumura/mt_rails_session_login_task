class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :correct_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # ユーザ登録に成功した場合の処理
      log_in(@user)
      flash[:notice] = 'アカウントを登録しました'
      redirect_to user_path(@user.id)
    else
      # ユーザ登録に失敗した場合の処理
      flash.now[:notice] = 'メールアドレスまたはパスワードに誤りがあります'
      render :new
    end
  end

  def edit
  end

  def update
    # 成功した時の処理を入れる
    flash[:notice] = 'アカウントを更新しました'
  end

  def show
    @user = User.find(params[:id])
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
