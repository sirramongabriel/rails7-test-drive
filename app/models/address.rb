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
class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :addressable_id, :addressable_type, :street_address, :city, :state, :zip_code, presence: true
end
