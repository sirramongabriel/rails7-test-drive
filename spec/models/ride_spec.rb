require "rails_helper" 

RSpec.describe Ride, type: :model do
  describe 'associations' do
    it { should have_one(:start_address) }
    it { should have_one(:destination_address) }
  end

  describe 'validations' do
    it { should have_db_column(:commute_distance_in_miles) }
    it { should have_db_column(:commute_duration_in_hours) }
    it { should have_db_column(:distance_in_miles) }
    it { should have_db_column(:driving_distance_in_miles) }
    it { should have_db_column(:driving_duration_in_hours) }
    it { should have_db_column(:duration_in_hours) }
    it { should have_db_column(:earnings) }
    it { should have_db_column(:score) }
  end
end