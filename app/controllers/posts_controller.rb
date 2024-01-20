class PostsController < ApplicationController
  before_action :set_user

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @post = @user.posts.new(post_params)
    if @post.save
      flash[:success] = 'Post created successfully😎!'
      redirect_to user_posts_path(@user)
    else
      flash[:alert] = 'Post not created😢!'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
