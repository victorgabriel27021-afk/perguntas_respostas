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

    old_value = vote.value
    new_value = params[:value].to_i

    if old_value == new_value
      redirect_to question_path(@answer.question)
      return
    end

    if old_value == 1
      @answer.user.add_reputation(-10)
    elsif old_value == -1
      @answer.user.add_reputation(2)
    end

    vote.value = new_value
    vote.save

    if new_value == 1
      @answer.user.add_reputation(10)
    elsif new_value == -1
      @answer.user.add_reputation(-2)
    end

    redirect_to question_path(@answer.question)
  end

  private

  def answer_params
    params.require(:answer).permit(:description)
  end
end