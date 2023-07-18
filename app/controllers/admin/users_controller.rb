class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "会員情報を変更に成功しました。"
      redirect_to admin_user_path(@user.id)
    else
      flash.now[:danger] = "会員情報の変更ができませんでした。"
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end

end
