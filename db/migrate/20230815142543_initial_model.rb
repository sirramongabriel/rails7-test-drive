class InitialModel < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street_address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip_code, null: false
      t.string :addressable_id, null: false
      t.string :addressable_type, null: false

      t.timestamps
    end
    add_index "addresses", [:addressable_id, :addressable_type], name: "index_addresses_by_id_and_type"

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
    add_index "rides", [:score], name: "index_rides_by_score"
  end
end
