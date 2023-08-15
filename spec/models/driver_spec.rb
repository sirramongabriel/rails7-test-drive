require "rails_helper" 

RSpec.describe Driver, type: :model do
  describe 'associations' do
    it { should have_one(:home_address) }
  end
end