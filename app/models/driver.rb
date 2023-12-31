# == Schema Information
#
# Table name: drivers
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Driver < ApplicationRecord
  has_one :home_address, as: :addressable, class_name: 'Address', dependent: :destroy
  has_many :rides
end
