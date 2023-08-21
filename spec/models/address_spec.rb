# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  addressable_type :string
#  city             :string
#  state            :string
#  street_address   :string
#  zip_code         :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  addressable_id   :integer
#
require "rails_helper" 

RSpec.describe Address, type: :model do
  let(:address) { Factory.build(:address) }
  let(:invalid_address) { Factory.build(:invalid_address) }

  describe 'associations' do
    it { should belong_to(:addressable) }
  end

  describe 'certifies the following columns' do
    it { should have_db_column(:addressable_id).of_type(:integer) }
    it { should have_db_column(:addressable_type).of_type(:string) }
    it { should have_db_column(:street_address).of_type(:string) }
    it { should have_db_column(:city).of_type(:string) }
    it { should have_db_column(:state).of_type(:string) }
    it { should have_db_column(:zip_code).of_type(:string) }
  end

  describe 'ensures attribute presence' do
    it { should validate_presence_of(:addressable_id) }
    it { should validate_presence_of(:addressable_type) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
  end
end
