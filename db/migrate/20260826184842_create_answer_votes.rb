class CreateAnswerVotes < ActiveRecord::Migration[7.2]
  def change
    create_table :answer_votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
