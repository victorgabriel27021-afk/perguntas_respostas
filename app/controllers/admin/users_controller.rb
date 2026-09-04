class Admin::UsersController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :require_admin

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
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user == current_user
      redirect_to admin_users_path,
                  alert: t("admin_users.cannot_delete_self")
    else
      @user.destroy
      redirect_to admin_users_path,
                  notice: t("admin_users.deleted")
    end
  end

  def toggle_admin
    @user = User.find(params[:id])

    if @user == current_user
      redirect_to admin_users_path,
                  alert: t("admin_users.cannot_change_own_permission")
    else
      @user.update(admin: !@user.admin?)
      redirect_to admin_users_path,
                  notice: t("admin_users.permission_updated")
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def require_admin
    redirect_to dashboard_path unless current_user.admin?
  end
end