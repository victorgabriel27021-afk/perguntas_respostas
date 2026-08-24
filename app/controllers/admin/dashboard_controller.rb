class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @users_count = User.count
  end

  private

  def require_admin
    redirect_to dashboard_path unless current_user.admin?
  end
end