class Admin::ColorsController < ApplicationController
  def index
    @color = Color.new
    @colors = Color.all
  end
  
  def create
    @color = Color.new(color_params)
    if @color.save
      redirect_to admin_colors_path
    else
      @colors = Color.all
      render 'index'
      #フラッシュメーセージ検討
    end
  end

  def edit
    @color = Color.find(params[:id])
  end
  
  def update
    @color = Color.find(params[:id])
    if @color.update(color_params)
      redirect_to admin_colors_path
    else
      render 'edit'
    end
  end


 private
 
 def color_params
   params.require(:color).permit(:name)
 end
end