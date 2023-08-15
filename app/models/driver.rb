class Driver < ApplicationRecord
  has_one :home_address, as: :addressable, class_name: 'Address', dependent: :destroy
end
