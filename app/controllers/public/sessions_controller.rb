# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
   before_action :configure_sign_in_params, only: [:create]
   before_action :user_state,  only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

    #ゲストログイン機能のアクション
   def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: "guestuserでログインしました。"
   end

   protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
   end
   #退会したユーザーはログインできないようにする
   def user_state
    @user = User.find_by(email: params[:user][:email])
    return if @user&.valid_password?(params[:user][:password]) && (@user.is_deleted == false)
    redirect_to new_user_session_path, notice: "ログイン失敗しました。"
   end

end

