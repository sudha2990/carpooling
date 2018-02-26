class CreateTravellers < ActiveRecord::Migration
  def change
    create_table :travellers do |t|
      t.integer :user_id
      t.integer :car_id
      t.integer :owner_id
      t.integer :ride_id

      t.timestamps null: false
    end
  end
end
