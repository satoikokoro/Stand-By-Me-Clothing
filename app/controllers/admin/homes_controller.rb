class Admin::HomesController < ApplicationController
  #ユーザーが認証されていることを確認するdeviseのメソット
  before_action :authenticate_admin!

  def top
    @cloths = Cloth.all
  end

end
