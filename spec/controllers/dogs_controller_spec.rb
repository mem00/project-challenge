require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  describe '#index' do
    it 'displays recent dogs' do
      2.times { create(:dog, user: User.new ) }
      get :index
      expect(assigns(:dogs).size).to eq(2)
    end
  end
end
