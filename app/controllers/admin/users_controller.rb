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
    is_deleted_params = user_params[:is_deleted]

    if @user.update(user_params)
      if is_deleted_params == "true"
        @user.cloths.destroy_all
        @user.storages.destroy_all
      end
      redirect_to admin_user_path
    else
      render 'edit'
    end

  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :is_deleted)
  end
end
