class Admin::ClothsController < ApplicationController
  #ユーザーが認証されていることを確認するdeviseのメソット
  before_action :authenticate_user!

  def index
    @cloths = Cloth.all
  end

  def show
    @cloth = Cloth.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    @cloth = Cloth.find(params[:id])
    if @cloth.destroy
       redirect_to admin_cloths_path
    else
      render 'show'
    end
  end

end
