class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    # ネストされたURLからpost_idを取得し、対象の投稿を特定
    @post = Post.find(params[:post_id])
    # 特定した投稿に紐づくコメントを作成
    @comment = @post.comments.create(comment_params)
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end

