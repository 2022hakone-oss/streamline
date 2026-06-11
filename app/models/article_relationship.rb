class ArticleRelationship < ApplicationRecord
  # belongs_to :article だった部分を、以下のように Post に繋ぎ直します
  belongs_to :post, foreign_key: :article_id
  belongs_to :tag
  
  validates :tag_id, uniqueness: { scope: :article_id }
end