class Admin::ColorsController < ApplicationController
  #ユーザーが認証されていることを確認するdeviseのメソット
  before_action :authenticate_admin!

  def index
    @color = Color.new
    @colors = Color.all
  end

  def create
    @color = Color.new(color_params)
    if @color.save
      flash[:notice] = "登録に成功しました。"
      redirect_to admin_colors_path
    else
      @colors = Color.all
      flash.now[:alert] = "登録に失敗しました。"
      render 'index'
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