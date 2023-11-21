class CommentsController < ApplicationController
  before_action :set_post_and_user, only: [:new, :create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to user_posts_path(@user), notice: 'Comment was successfully created.'
    else
      redirect_to user_posts_path(@user), alert: 'Error creating comment.'
    end
  end

  private

  def set_post_and_user
    @post = Post.find(params[:post_id])
    @user = @post.author
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
