class Ride < ApplicationRecord
  has_one :start_address, as: :addressable, class_name: 'Address', dependent: :destroy
  has_one :destination_address, as: :addressable, class_name: 'Address', dependent: :destroy
end
