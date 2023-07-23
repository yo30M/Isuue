class Admin::PostsController < ApplicationController

  def index
  end

  def show
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:address, :image, :comfort, :environment, :tag_list)
  end

end
