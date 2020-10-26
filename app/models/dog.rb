class Dog < ApplicationRecord
  include Pagination
  has_many_attached :images
  belongs_to :user
  has_many :dog_likes

  def self.ordered_likes_last_hour
    left_joins(:dog_likes).group(:id).where('dog_likes.created_at >= ?', DateTime.now - 1.day).order('COUNT(dog_likes.id) DESC')
  end
end
