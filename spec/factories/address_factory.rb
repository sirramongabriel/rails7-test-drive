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
FactoryGirl.define do
  factory :address do
    street_address { FFaker::AddressUS.street_address }
    city { FFaker::AddressUS.city }
    state { FFaker::AddressUS.state }
    zip { FFaker::AddressUS.zip_code }
    addressable_id  Array (500...1000).sample
    addressable_type ['driver_address', 'start_address', 'destination_address'].sample
  end

  factory :invalid_address, parent: :address do
    street_address ''
    city ''
    state ''
    zip ''
  end
end
