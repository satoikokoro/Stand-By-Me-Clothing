class Public::FavoritesController < ApplicationController

  def create
    cloth = Cloth.find(params[:cloth_id])
    favorite = current_user.favorites.new(cloth_id: cloth.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    cloth = Cloth.find(params[:cloth_id])
    favorite = current_user.favorites.find_by(cloth_id: cloth.id)
    favorite.destroy
    redirect_to request.referer
  end

end
