class CommentsController < ApplicationController
  def create
    # ネストされたURLからpost_idを取得し、対象の投稿を特定
    @post = Post.find(params[:post_id])
    # 特定した投稿に紐づくコメントを作成
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to post_path(@post), notice: "コメントを投稿しました！"
    else
      # 失敗した場合は投稿詳細画面を再表示
      redirect_to post_path(@post), alert: "コメントの投稿に失敗しました。"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end

