class AddUserToDogs < ActiveRecord::Migration[5.2]
  def change
    add_reference :dogs, :user, foreign_key: true, index: true
  end
end
