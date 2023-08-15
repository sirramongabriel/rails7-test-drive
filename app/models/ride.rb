class Ride < ApplicationRecord
  has_one :start_address, as: :addressable
  has_one :destination_adress, as: :addressable
end
