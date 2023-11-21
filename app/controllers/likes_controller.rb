class LikesController < ApplicationController
  before_action :set_user_and_post, only: [:create]

  def create
    if @post.likes.exists?(user: @user)
      redirect_to user_posts_path(@user), alert: 'You have already liked this post.'
    else
      @like = @post.likes.build(user: @user)

      if @like.save
        redirect_to user_posts_path(@user), notice: 'Post liked successfully.'
      else
        redirect_to user_posts_path(@user), alert: 'Error liking the post.'
      end
    end
  end

  private

  def set_user_and_post
    @user = current_user
    @post = Post.find(params[:post_id])
  end
end
