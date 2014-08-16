class CreateParkingAreas < ActiveRecord::Migration
  def change
    create_table :parking_areas do |t|
      t.integer :capacity, null: false
      t.timestamps
    end
  end
end
