class Public::CommentsController < ApplicationController

  def create
    @cloth = Cloth.find(params[:cloth_id])
    cloth_comment = current_user.comments.new(comment_params)
    cloth_comment.cloth_id = @cloth.id

    if cloth_comment.save
      flash[:notice] = "コメントが投稿されました。"
      @comment = Comment.new
    else
      flash[:aleert] = "コメントの投稿に失敗しました。"
    end
    redirect_to cloth_path(@cloth)
  end

  def destroy
    @cloth = Cloth.find(params[:cloth_id])
    @comment = Comment.find_by(id: params[:id], cloth_id: params[:cloth_id])

    if @comment.user == current_user
      @comment.destroy
      flash[:notice] = "コメントが削除されました。"
    else
      flash[:alert] = "このコメントを削除する権限がありません。"
    end
    redirect_to cloth_path(@cloth)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end