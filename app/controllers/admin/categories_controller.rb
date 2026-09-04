class Admin::CategoriesController < ApplicationController
layout "admin"

before_action :authenticate_user!
before_action :require_admin

def index
@categories = Category.all
end

def new
@category = Category.new
end

def create
@category = Category.new(category_params)

if @category.save
  redirect_to admin_categories_path
else
  render :new, status: :unprocessable_entity
end

end

def edit
@category = Category.find(params[:id])
end

def update
@category = Category.find(params[:id])

if @category.update(category_params)
  redirect_to admin_categories_path
else
  render :edit, status: :unprocessable_entity
end

end

def destroy
@category = Category.find(params[:id])

if @category.questions.exists?
  redirect_to admin_categories_path,
              alert: t("admin_categories.cannot_delete")
else
  @category.destroy
  redirect_to admin_categories_path,
              notice: t("admin_categories.deleted")
end

end

private

def category_params
params.require(:category).permit(:name)
end

def require_admin
redirect_to dashboard_path unless current_user.admin?
end
end
