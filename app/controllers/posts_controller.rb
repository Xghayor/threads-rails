class PostController < ApplicationController
  def index
    @posts = Post.all.includes(:user)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end
end
