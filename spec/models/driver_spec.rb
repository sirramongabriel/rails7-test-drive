# == Schema Information
#
# Table name: drivers
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper" 

RSpec.describe Driver, type: :model do
  describe 'associations' do
    it { should have_one(:home_address) }
  end

  # Feeling like I can remove this block since id is added automatically
  describe 'validations' do 
    it { should have_db_column(:id).of_type(:integer) }
  end
end
