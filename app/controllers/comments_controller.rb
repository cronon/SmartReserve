class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.club_id = params[:club_id]
    @comment.save
    redirect_to :back
  end

  def destroy    
    @comment = Comment.find(params[:id]).destroy
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:description)
    end
end
