class Public::ClothsController < ApplicationController
  #ユーザーが認証されていることを確認するdeviseのメソット
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy,]

  def new
    @cloth = Cloth.new
    @genres = Genre.all
    @storages = current_user.storages
    @colors = Color.all
  end

  def create
    @genres =Genre.all
    @storages = Storage.all
    @colors = Color.all
    @cloth = Cloth.new(cloth_params)

    #カラープロパティをAPIから取得
    color_properties = Vision.get_image_data(cloth_params[:image])
    @cloth.user_id = current_user.id
     if @cloth.save
       color_properties.each do |color_property|
         #pp color_property
         @cloth.color_properties.create(green: color_property['color']['green'],
                                        red:  color_property['color']['red'],
                                        blue:  color_property['color']['blue'],
                                        score:  color_property['score'],
                                        pixelFraction:  color_property['pixelFraction']
                                        )
       end
       flash[:notice] = "投稿に成功しました"
       redirect_to cloths_path
     else
       flash.now[:alert] = "投稿に失敗しました。"
       render "new"
     end
  end


  def index
    #ページ分の決められた数のデータを新しい順に全て取得
    @cloths = Cloth.page(params[:page]).per(12)
    @genres = Genre.all
  end

  def show
    @cloth = Cloth.find(params[:id])
    @comment = Comment.new

  end

  def edit
    @cloth = Cloth.find(params[:id])
    @storages = current_user.storages
  end

  def update
    @cloth = Cloth.find(params[:id])
    if @cloth.update(cloth_params)
      redirect_to cloth_path
    else
      render "edit"
    end
  end
  #フラッシュメッセージ要検討

  def destroy
    cloth = Cloth.find(params[:id])
    cloth.destroy
    redirect_to cloths_path
  end

  def genre_search
    @genre = Genre.find(params[:id])
    @cloths = @genre.cloths.page(params[:page]).per(12)
    @genres = Genre.all
  end

  private

  def cloth_params
    params.require(:cloth).permit(:image, :name, :description, :genre_id, :storage_id, color_ids:[])
  end

  #ログイン中のユーザーのみアクションを適用させる
  def ensure_correct_user
    @cloth = Cloth.find(params[:id])
    unless @cloth.user == current_user
      redirect_to cloths_path(current_user), notice: "他ユーザーの衣類のため、処理できません。"
    end
  end

end
