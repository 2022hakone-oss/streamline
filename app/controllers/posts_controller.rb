class PostsController < ApplicationController
  # 投稿一覧を表示
  def index
    if params[:tag_ids]
      @posts = []
      params[:tag_ids].each do |key, value|
        tag = Tag.find_by(name: key)
        @posts += tag.posts if tag && value == "1"
      end
      @posts.uniq!
    else
      @posts = Post.all.order(created_at: :desc)
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
      redirect_to posts_path, notice: "投稿が完了しました"
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