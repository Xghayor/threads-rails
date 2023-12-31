class PostsController < ApplicationController
  before_action :set_user

  def index
    @posts = @user.posts
  end

  def show
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    comment_count = 0
    likes_count = 0

    @post = current_user.posts.build(post_params)
    @post.comments_counter = comment_count
    @post.likes_counter = likes_count

    if @post.save
      redirect_to user_posts_path(current_user)
    else
      render :new
    end
  end

  private

  def set_user
    @user = User.first
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
