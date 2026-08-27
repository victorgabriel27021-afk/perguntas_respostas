class AddReputationToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :reputation, :integer
  end
end
