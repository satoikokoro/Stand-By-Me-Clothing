class Admin::CommentsController < ApplicationController
    #ユーザーが認証されていることを確認するdeviseのメソット
    before_action :authenticate_user!

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to request.referer
    end
end
