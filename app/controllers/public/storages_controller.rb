class Public::StoragesController < ApplicationController
#ユーザーログインがされていることを確認するdeviseのメソット
before_action :authenticate_user!
before_action :ensure_correct_user, only: [:edit, :update, :destroy,]


  def index
    # gemの機能によりallの記述を省略
    @storages = current_user.storages.page(params[:page]).per(12)
  end

  def new
    @storage = Storage.new
    @storages = current_user.storages.all
  end

  def show
    @storage = Storage.find(params[:id])
    @cloths = @storage.cloths.all
  end

  def create
    @storage = Storage.new(storage_params)
    @storage.user_id = current_user.id
    if @storage.save
      flash[:notice] = "登録に成功しました"
      redirect_to new_storage_path
    else
      flash.now[:alert] = "登録に失敗しました。"
      @storages = Storage.all
      render 'new'
      #フラッシュメッセージ検討
    end
  end

  def edit
    @storage = Storage.find(params[:id])
  end

  def update
    @storage = Storage.find(params[:id])
    if @storage.update(storage_params)
      redirect_to new_storage_path
    else
      render 'edit'
    end
  end

  def destroy
    storage = Storage.find(params[:id])
    storage.destroy
    redirect_to request.referer
  end

  private

  def storage_params
    params.require(:storage).permit(:name, :image)
  end

    #ログイン中のユーザーのみコントローラーアクションを処理させる
  def ensure_correct_user
    @storage = Storage.find(params[:id])
    unless @storage.user == current_user
      redirect_to storages_path(current_user), notice: "他ユーザーの衣類のため、処理できません。"
    end
  end

end