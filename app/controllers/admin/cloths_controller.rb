class Admin::ClothsController < ApplicationController
  def show
    @cloth = Cloth.find(params[:id])
    @comment = Comment.new
  end
end
