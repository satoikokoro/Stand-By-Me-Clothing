class Public::StoragesController < ApplicationController

  def index
    @storages = Storage.page(params[:page]).per(12)
    @storages_all = Storage.all
  end

  def new
    @storage = Storage.new
    @storages = Storage.all
  end

  def create
    @storage = Storage.new(storage_params)
    if @storage.save
      redirect_to new_storage_path
    else
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

end