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
alert: "Você não pode excluir sua própria conta."
else
@user.destroy
redirect_to admin_users_path,
notice: "Usuário excluído com sucesso."
end
end

def toggle_admin
@user = User.find(params[:id])

if @user == current_user
redirect_to admin_users_path,
alert: "Você não pode alterar sua própria permissão de administrador."
else
@user.update(admin: !@user.admin?)
redirect_to admin_users_path,
notice: "Permissão de administrador atualizada."
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