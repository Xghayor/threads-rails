class LikesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
  
    unless @post.likes.exists?(user: @user)
      @like = @post.likes.build(user: @user)
  
      if @like.save
        redirect_to user_posts_path(@user), notice: 'Post liked successfully.'
      else
        redirect_to user_posts_path(@user), alert: 'Error liking the post.'
      end
    else
      redirect_to user_posts_path(@user), alert: 'You have already liked this post.'
    end
  end
  
end
