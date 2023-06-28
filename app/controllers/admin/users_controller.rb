class Admin::UsersController < ApplicationController
    #ユーザーが認証されていることを確認するdeviseのメソット
    before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user =User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path
    else
      render 'edit'
    end
  end


  private

  def user_params
    params.require(:user).permit(:introduction, :user_status)
  end
end
