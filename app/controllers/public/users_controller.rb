class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user
  before_action :ensure_guest_user, only: [:edit]

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

  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorited_posts = Post.find(favorites)
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
