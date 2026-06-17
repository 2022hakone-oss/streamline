class PostsController < ApplicationController
  # 投稿一覧を表示
  def index
  if params[:tag_ids].present?
    # 送られてきたタグID（複数可）を持つ投稿だけを絞り込む
    @posts = Post.joins(:tags).where(tags: { id: params[:tag_ids] }).distinct
  else
    # タグが選択されていない場合はすべて表示
    @posts = Post.all
  end
end

  # 新規投稿画面を表示
  def new
    @post = Post.new
  end

  # 投稿をデータベースに保存
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to blogs_path, notice: "投稿が完了し,カレンダーに反映されました！"
    else
      # バリデーションエラーなどの場合は再描画
      render :new, status: :unprocessable_entity
    end
  end

  # 投稿詳細を表示
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new # 空のコメントオブジェクト
    @associated_blog = Blog.find_by(title: @post.title)
  end

  private

  # 安全にデータを受け取るためのストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :body, tag_ids: [])
  end
end