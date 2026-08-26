class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find(params[:question_id])
    @answer = current_user.answers.build(answer_params)
    @answer.question = @question

    if @answer.save
      redirect_to question_path(@question)
    else
      redirect_to question_path(@question)
    end
  end

  def vote
    @answer = Answer.find(params[:id])

    vote = current_user.answer_votes.find_or_initialize_by(answer: @answer)
    vote.value = params[:value].to_i
    vote.save

    redirect_to question_path(@answer.question)
  end

  private

  def answer_params
    params.require(:answer).permit(:description)
  end
end