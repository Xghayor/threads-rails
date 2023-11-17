class CommentsController < ApplicationController
    def new
      @user = current_user
      @post = Post.find(params[:post_id])
      @comment = Comment.new
    end
  
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)
      @comment.author = current_user
  
      @user = Post.find(params[:post_id]).author
  
      if @comment.save
        redirect_to user_posts_path(@user), notice: 'Comment was successfully created.'
      else
        redirect_to user_posts_path(@user), alert: 'Error creating comment.'
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:text)
    end
  end