class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :cells_user1
      t.string :cells_user2
      t.string :winner
      t.string :turn
      t.belongs_to :user1
      t.belongs_to :user2

      t.timestamps
    end
  end
end
