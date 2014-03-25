class CommentsController < ApplicationController
  before_action :set_comment

  def new
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:description, :club_id, :user_id)
    end
end
