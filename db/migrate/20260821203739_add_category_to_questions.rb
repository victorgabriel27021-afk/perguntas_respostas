class AddCategoryToQuestions < ActiveRecord::Migration[7.2]
  def change
    add_reference :questions, :category, null: true, foreign_key: true
  end
end
