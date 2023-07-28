class Admin::GenresController < ApplicationController
    #ユーザーが認証されていることを確認するdeviseのメソット
    before_action :authenticate_admin!

  def index
    @genre = Genre.new
    @genres = Genre.all
  end


  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice]= "登録に成功しました。"
      redirect_to  admin_genres_path
    else
      @genres = Genre.all
      flash.now[:alert] = "登録に失敗しました。"
      render 'index'
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      render "edit"
    end
  end

 private

  def genre_params
   params.require(:genre).permit(:name)
  end
end