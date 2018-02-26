class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :seat
      t.string :car_type
      t.string :brand
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
