class Article < ApplicationRecord
  .
  .
  has_many :article_relationships, dependent: :destroy
  has_many :tags, through: :article_relationships
  .
  .
   def save_tags(savearticle_tags)
    savearticle_tags.each do |new_name|
      article_tag = Tag.find_or_create_by(name: new_name)
      self.tags << article_tag
    end
   end
end
