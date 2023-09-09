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

  describe '.calculate_earnings' do
    # calulate_earnings formula: $12 + $1.50 per mile beyond 5 miles + (ride duration) * $0.70 per minute beyond 15 minutes

    context 'within the flatrate parameters'
    let(:distance) { 5 }
    let(:duration) { 15 }

    it 'calculates the earnings correctly' do
      earnings = Ride.calculate_earnings(distance, duration)
      expect(earnings).to eq('12.00')
    end

    context 'correct calculation with a longer distance' do
      let(:distance) { 8 }

      it { expect(Ride.calculate_earnings(distance, duration)).to eq('16.50') }
    end

    context 'correct calculation with a longer duration' do
      let(:duration) { 20 }

      it { expect(Ride.calculate_earnings(distance, duration)).to eq('15.50') }
    end
  end

  describe '.calculate_score' do
    let(:commute_duration) { 30 }
    let(:ride_duration) { 45 } 
    let(:ride_distance) { 5 }

    it 'calculates the score correctly' do
      score = Ride.calculate_score(commute_duration, ride_duration, ride_distance)

      expect(score).to eq(0.44) 
    end
  end
end
