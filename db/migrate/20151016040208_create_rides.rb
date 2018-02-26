class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :source
      t.string :destination
      t.float :cost
      t.time :arrival_time
      t.time :departure_time
      t.date :start_date
      t.text :route, array: true, default: []
      t.integer :user_id
      t.integer :car_id
      t.integer :seats
      t.text :travellers, array: true, default: []

      t.timestamps null: false
    end
  end
end
