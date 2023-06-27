class Public::ClothsController < ApplicationController
  #ユーザーが認証されていることを確認するdeviseのメソット
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :create]

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
       redirect_to cloths_path
     else
       render "new"
     end
  end
      #フラッシュメッセージ検討

  def index
    @cloths = Cloth.page(params[:page]).per(12)
  end

  def show
    @cloth = Cloth.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @cloth = Cloth.find(params[:id])
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
