class Post < ApplicationRecord
  # アソシエーション
  has_many :comments, dependent: :destroy
  
  #  ここを追加（PostとTagを、article_relationshipsテーブルを使って結びつける）
  has_many :article_relationships, foreign_key: :article_id, dependent: :destroy
  has_many :tags, through: :article_relationships

  #  ここから下は元からあったカレンダー連携の処理
  after_create :copy_to_calendar

  private

  def copy_to_calendar
    # Postが作られたら、その内容を使ってBlog（カレンダー）のレコードを自動作成します
    Blog.create(
      title: self.title,
      start_time: self.created_at
    )
  end
end