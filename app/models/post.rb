class Post < ApplicationRecord
  # アソシエーション
  has_many :comments, dependent: :destroy
  
  acts_as_taggable_on :tags

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