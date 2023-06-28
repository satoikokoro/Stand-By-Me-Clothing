class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method).page(params[:page]).per(15)
		else
			@records = Cloth.search_for(@content, @method).page(params[:page]).per(15)
		end
  end


end
