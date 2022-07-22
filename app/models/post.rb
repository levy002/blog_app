class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  after_save :update_post_counter

  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :nullify
  has_many :likes, dependent: :nullify

  def update_post_counter
    author.increment!(:posts_counter)
  end

  def recent_comments
    comments.order(created_at: :asc).includes(:post).limit(5)
  end
end
