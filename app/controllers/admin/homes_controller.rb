class Admin::HomesController < ApplicationController
  #ユーザーが認証されていることを確認するdeviseのメソット
  before_action :authenticate_admin!

  def top
    @cloths = Cloth.page(params[:page]).per(12)
  end

end
