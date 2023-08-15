require "rails_helper" 

RSpec.describe Address, type: :model do
  describe 'associations' do
    it { should belong_to(:addressable) }
  end

  describe 'validations' do
    it { should have_db_column(:addressable_id) }
    it { should have_db_column(:addressable_type) }
    it { should have_db_column(:street_address) }
    it { should have_db_column(:city) }
    it { should have_db_column(:state) }
    it { should have_db_column(:zip_code) }
  end
end