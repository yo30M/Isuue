class Public::PostsController < ApplicationController
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}")
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def new
    @post = Post.new
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end


  private

  def post_params
    params.require(:post).permit(:address, :image, :comfort, :environment, :tag_list)
  end

  def ensure_user
    @posts = current_user.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to new_post_path
  end

end
