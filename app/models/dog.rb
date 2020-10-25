class Dog < ApplicationRecord
  include Pagination
  has_many_attached :images
  belongs_to :user
  has_many :dog_likes
end
