class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions
  has_many :answers, dependent: :destroy

  has_one_attached :avatar

  has_many :answer_votes, dependent: :destroy
end