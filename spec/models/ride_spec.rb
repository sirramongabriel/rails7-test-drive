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
require "rails_helper" 

RSpec.describe Ride, type: :model do
  describe 'associations' do
    it { should have_one(:start_address) }
    it { should have_one(:destination_address) }
  end

  describe 'validations' do
    it { should have_db_column(:commute_distance_in_miles).of_type(:string) }
    it { should have_db_column(:commute_duration_in_minutes).of_type(:string) }
    it { should have_db_column(:distance_in_miles).of_type(:string) }
    it { should have_db_column(:duration_in_minutes).of_type(:string) }
    it { should have_db_column(:earnings).of_type(:integer) }
    it { should have_db_column(:score).of_type(:float) }
  end
end
