class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
  if params[:search].present?
    @questions = Question.where("description LIKE ?", "%#{params[:search]}%")
  else
    @questions = Question.all
  end
end

  def my_questions
  @questions = current_user.questions
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
  @question = current_user.questions.find(params[:id])
  @categories = Category.all
end

   def update
  @question = current_user.questions.find(params[:id])

  if @question.update(question_params)
    redirect_to question_path(@question)
  else
    render :edit, status: :unprocessable_entity
  end
end

def destroy
  @question = current_user.questions.find(params[:id])
  @question.destroy

  redirect_to questions_path
end

  private

  def question_params
    params.require(:question).permit(:description, :category_id)
  end
end