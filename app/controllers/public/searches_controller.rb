class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.where(is_deleted: :false).search_for(@content, @method).page(params[:page]).per(15)
		else
			@records = Cloth.where(privacy_status: :public).search_for(@content, @method).page(params[:page]).per(15)
		end
  end
end
