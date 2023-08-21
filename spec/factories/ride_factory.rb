# == Schema Information
#
# Table name: rides
#
#  id                          :integer          not null, primary key
#  commute_distance_in_miles   :string
#  commute_duration_in_minutes :string
#  distance_in_miles           :string
#  duration_in_minutes         :string
#  earnings                    :integer
#  score                       :float
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  driver_id                   :integer
#
# Indexes
#
#  index_rides_by_score  (score)
#
FactoryGirl.define do
  factory :ride do
      
  end

  factory :invalid_ride, parent: :ride do
  end
end
