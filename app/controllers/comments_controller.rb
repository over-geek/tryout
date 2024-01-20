class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params.merge(post: @post))

    if @comment.save
      flash[:success] = 'Comment successfully added! 😎'
      redirect_to user_post_path(@post.author, @post)
    else
      flash[:alert] = 'Comment not added! 😢'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
