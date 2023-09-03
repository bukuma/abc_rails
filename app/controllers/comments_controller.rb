class CommentsController < ApplicationController
    before_action :authenticate_user!

    def new
      @post = Post.find(params[:post_id])
      @comment = Comment.new
      @comments = Comment.where(post_id: params[:post_id])
      render :new
    end
  
    def create
      @comment = Comment.new(comment_params)
      if @comment.save
        redirect_to new_comment_path(params[:post_id]), notice: 'コメントしました'
      else
        # 失敗した場合には app/views/posts/show.html.erb で必要な変数を取得
        @post = Post.find(params[:post_id])
        @comments = Comment.where(post_id: params[:post_id])
        render :new, status: :unprocessable_entity
      end
    end
  
    private
    def comment_params
      params.require(:comment).permit(:content).merge(post_id: params[:post_id])
    end
end
