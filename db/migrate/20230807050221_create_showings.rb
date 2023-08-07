class CreateShowings < ActiveRecord::Migration[7.0]
  def change
    create_table :showings do |t|
      t.references :cinema, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.references :timeslot, null: false, foreign_key: true

      t.timestamps
    end

    add_index :showings, [:cinema_id, :timeslot_id], unique: true
  end
end
