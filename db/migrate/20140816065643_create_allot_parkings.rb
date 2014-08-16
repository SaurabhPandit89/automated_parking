class CreateAllotParkings < ActiveRecord::Migration
  def change
    create_table :allot_parkings do |t|
      t.integer :slot_number
      t.string :registration_number
      t.string :color
      t.timestamps
    end
  end
end
