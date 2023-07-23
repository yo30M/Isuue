class Admin::CommentsController < ApplicationController

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
