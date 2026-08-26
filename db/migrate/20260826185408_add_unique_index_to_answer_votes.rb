class AddUniqueIndexToAnswerVotes < ActiveRecord::Migration[7.2]
  def change
    add_index :answer_votes, [:user_id, :answer_id], unique: true
  end
end
