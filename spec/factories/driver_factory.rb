# == Schema Information
#
# Table name: drivers
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryGirl.define do
  factory :driver do
    
  end

  factory :invalid_driver, parent: :driver do
  end
end
