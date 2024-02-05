class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      # ログイン成功した場合
      flash[:notice] = 'ログインしました'
      log_in(user)
      redirect_to user_path(user.id)
    else
      # ログイン失敗した場合
      flash.now[:notice] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
