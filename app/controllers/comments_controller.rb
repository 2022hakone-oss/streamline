class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
  @post = Post.find(params[:post_id])
  @comment = @post.comments.build(comment_params)
  @comment.user_id = current_user.id # ログインユーザーを紐付ける場合

  if @comment.save
    redirect_to @post, noble: "コメントを投稿しました！"
  else
    # 💡 保存に失敗した場合、エラー内容を画面に警告として出す
    redirect_to @post, alert: "コメントの保存に失敗しました: #{@comment.errors.full_messages.join(', ')}"
  end
end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end

