class CreateTimeslots < ActiveRecord::Migration[7.0]
  def change
    create_table :timeslots do |t|
      t.time :time, default: Time.now().change(hour: 10, min: 0)

      t.timestamps
    end

    add_index :timeslots, :time, unique: true
  end
end
