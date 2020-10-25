module DogsHelper
  def number_of_likes dog
    dog.dog_likes.size
  end

  def user_liked_dog dog
    DogLike.where(dog_id: dog.id, user_id: current_user.try(:id)).present?
  end
end
