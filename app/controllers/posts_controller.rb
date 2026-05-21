class PostsController < ApplicationController
  # 投稿一覧を表示
  def index
    @posts = Post.all.order(created_at: :desc) # 新しい順に取得
  end

  # 新規投稿画面を表示
  def new
    @post = Post.new
  end

  # 投稿をデータベースに保存
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿が完了しました！"
    else
      # バリデーションエラーなどの場合は再描画（Rails 7以降のTurbo対応）
      render :new, status: :unprocessable_entity
    end
  end
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new # 空のコメントオブジェクト（フォーム用）
  end

  private

  # 安全にデータを受け取るためのストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :body)
  end
end