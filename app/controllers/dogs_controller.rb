class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:like_dog]

  # GET /dogs
  # GET /dogs.json
  def index
    @page = params[:page] || 1
    if params[:likes].present?
      @dogs, @page, @num_of_pages = Dog.ordered_likes_last_hour.paginate(@page, {:filtered => true})
    else
      @dogs, @page, @num_of_pages = Dog.all.paginate(@page)
    end
  end

  # GET /dogs/1
  # GET /dogs/1.json
  def show
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
  end

  # GET /dogs/1/edit
  def edit
    redirect_to dog_path @dog unless @dog.user == current_user
  end

  # POST /dogs
  # POST /dogs.json
  def create
    @dog = Dog.new(dog_params)
    @dog.user = current_user

    respond_to do |format|
      if @dog.save
        format.html { redirect_to @dog, notice: 'Dog was successfully created.' }
        format.json { render :show, status: :created, location: @dog }
      else
        format.html { render :new }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dogs/1
  # PATCH/PUT /dogs/1.json
  def update
    respond_to do |format|
      if @dog.update(dog_params)
        format.html { redirect_to @dog, notice: 'Dog was successfully updated.' }
        format.json { render :show, status: :ok, location: @dog }
      else
        format.html { render :edit }
        format.json { render json: @dog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.json
  def destroy
    @dog.destroy
    respond_to do |format|
      format.html { redirect_to dogs_url, notice: 'Dog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like_dog
    DogLike.create!({
      dog_id: like_dog_params[:id],
      user_id: current_user.id
    })

    head 200 and return
  rescue => e
    puts "Error: #{e}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      @dog = Dog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dog_params
      params.require(:dog).permit(:name, :description, images: [])
    end

    def like_dog_params
      params.require(:dog).permit(:id)
    end
end
