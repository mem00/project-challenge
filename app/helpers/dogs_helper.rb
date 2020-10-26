module DogsHelper
  def number_of_likes dog
    #use count so filtered shows all likes
    dog.dog_likes.count
  end

  def user_liked_dog dog
    DogLike.where(dog_id: dog.id, user_id: current_user.try(:id)).present?
  end
end
