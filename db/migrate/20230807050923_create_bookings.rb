class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.integer :seat_number
      t.references :user, null: false, foreign_key: true
      t.references :showing, null: false, foreign_key: true

      t.timestamps
    end

    add_index :bookings, [:showing_id, :seat_number], unique: true
  end
end
