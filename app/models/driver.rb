class Driver < ApplicationRecord
  has_one :home_addresss, as: :addresable
end
