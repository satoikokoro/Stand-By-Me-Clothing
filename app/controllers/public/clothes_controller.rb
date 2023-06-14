class Public::ClothesController < ApplicationController

  def new
    @cloth = Cloth.new
    @genres = Genre.all
    @storages = Storage.all
    @colors = Color.all
  end

  def create
    @genres =Genre.all
    @storages = Storage.all
    @colors = Color.all
    @cloth = Cloth.new(cloth_params)
    @cloth.user_id = current_user.id
    # binding.pry
     if @cloth.save
       redirect_to clothes_path
     else
       render "new"
     end
  end
      #フラッシュメッセージ検討

  def index
    @clothes = Cloth.page(params[:page]).per(12)
  end

  def show
    @cloth = Cloth.find(params[:id])
  end

  def edit
    @cloth = Cloth.find(params[:id])
  end

  def update
    @cloth = Cloth.find(params[:id])
    if @cloth.update(cloth_params)
      redirect_to clothe_path
    else
      render "edit"
    end
  end
  #フラッシュメッセージ要検討

  def destroy
    cloth = Cloth.find(params[:id])
    cloth.destroy
    redirect_to clothes_path
  end

  private

  def cloth_params
    params.require(:cloth).permit(:image, :name, :description, :genre_id, :storage_id, color_ids:[])
  end

end
