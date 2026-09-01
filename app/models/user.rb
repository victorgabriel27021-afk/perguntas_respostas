class User < ApplicationRecord

  after_initialize :set_default_reputation, if: :new_record?
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions
  has_many :answers, dependent: :destroy

  has_one_attached :avatar

  has_many :answer_votes, dependent: :destroy

  has_many :notifications, dependent: :destroy

  def add_reputation(points)
  self.reputation += points
  save!
end

def reputation_level
  case reputation
  when 0...50
    "Novato"
  when 50...100
    "Colaborador"
  when 100...250
    "Especialista"
  else
    "Mestre"
  end
end

  private

def set_default_reputation
  self.reputation ||= 0
end
end