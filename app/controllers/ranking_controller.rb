class RankingController < ApplicationController
  def index
    @users = User.order(reputation: :desc)
  end
end