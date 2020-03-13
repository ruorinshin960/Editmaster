class Article < ApplicationRecord
  acts_as_taggable
  acts_as_taggable_on :labels
  belongs_to :user

  def self.search(search)
    if search
      Article.where('title LIKE(?)', "%#{search}%")
    else
      Sample.all
    end
  end

end
