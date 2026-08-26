class AnswerVote < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  validates :value, inclusion: { in: [-1, 1] }
end