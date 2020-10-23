class Dog < ApplicationRecord
  include Pagination
  has_many_attached :images
end
