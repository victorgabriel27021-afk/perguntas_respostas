class Admin::QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @questions = Question.all
  end

  private

  def require_admin
    redirect_to dashboard_path unless current_user.admin?
  end
end