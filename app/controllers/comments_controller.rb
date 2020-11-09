class CommentsController < ApplicationController

def create
 @comment = Comment.new
 if @comment.save
  redirect_to prototype_path(@comment.prototype)
 else
  render "prototypes/show"
 end
end

private
def comments_params
  params.require(:comment).permit(:text).merge(user_id: current_user.id,prototype_id: params[:prototype_id]) #permitの中身不安
end

end
