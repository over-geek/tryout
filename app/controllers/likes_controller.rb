class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])

    if @post.author
      @like = current_user.likes.build(post: @post)

      if @like.save
        flash[:success] = 'Like successfully added 😎!'
      else
        flash[:alert] = 'Could not add a like 😢!'
      end

      redirect_to user_post_path(@post.author, @post)
    else
      flash[:alert] = 'Post author not found 😢!'
      redirect_to root_path
    end
  end
end
