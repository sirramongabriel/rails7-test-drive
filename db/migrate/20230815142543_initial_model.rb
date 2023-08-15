class InitialModel < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :addressable_id
      t.string :addressable_type

      t.timestamps
    end
    create_table :drivers do |t|
      
      t.timestamps
    end
    create_table :rides do |t|
      t.integer :score
      t.integer :earnings
      t.string :duration_in_hours
      t.string :distance_in_miles
      t.string :commute_duration_in_hours
      t.string :commute_distance_in_miles
      t.string :driving_duration_in_hours
      t.string :driving_distance_in_miles

      t.timestamps
    end
  end
end
