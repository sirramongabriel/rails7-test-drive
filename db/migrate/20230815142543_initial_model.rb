class InitialModel < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.integer :addressable_id 
      t.string :addressable_type
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code

      t.timestamps
    end

    create_table :drivers do |t|
      t.timestamps
    end

    create_table :rides do |t|
      t.integer :driver_id
      t.string :distance_in_miles
      t.string :duration_in_minutes 
      t.string :commute_distance_in_miles 
      t.string :commute_duration_in_minutes
      t.integer :earnings 
      t.float :score
      t.timestamps
    end
    add_index "rides", [:score], name: "index_rides_by_score"
  end
end
