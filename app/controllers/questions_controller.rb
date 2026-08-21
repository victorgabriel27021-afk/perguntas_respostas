class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = Question.all
  end

  def new
  @question = current_user.questions.build
  @categories = Category.all
end

  def create
    @question = current_user.questions.build(question_params)

    if @question.save
      redirect_to questions_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
  @question = Question.find(params[:id])
  end

  def update
  @question = Question.find(params[:id])

  if @question.update(question_params)
    redirect_to question_path(@question)
  else
    render :edit, status: :unprocessable_entity
  end
end

def destroy
  @question = Question.find(params[:id])
  @question.destroy

  redirect_to questions_path
end

  private

  def question_params
    params.require(:question).permit(:description, :category_id)
  end
end