class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user

  def show
    @user = current_user
    @posts = @user.posts
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, success: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def confirmation
  end

  def withdrawal
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
