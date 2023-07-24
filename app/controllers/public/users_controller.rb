class Public::UsersController < ApplicationController
  #ログイン中のみ閲覧できるdeviseのメソット
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.where(is_deleted: false).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @cloths = @user.cloths.where(privacy_status: :public).page(params[:page]).per(12)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end


  def resign
    current_user.update(is_deleted: true)
    current_user.cloths.destroy_all
    current_user.storages.destroy_all
    reset_session
    flash[:notice] = "またのご利用をお待ちしております。"
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end

  #ログイン中のユーザーのみアクションを適用させる
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user), notice: "他のユーザーのため、処理できません。"
    end
  end

end