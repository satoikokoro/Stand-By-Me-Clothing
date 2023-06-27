class Public::UsersController < ApplicationController
  #ログイン中のみ閲覧できるdeviseのメソット
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update,:resign]

  def index
    @users = User.where(user_status: false)
  end

  def show
    @user = User.find(params[:id])
    @cloths = @user.cloths
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
    current_user.update(user_status: true)
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