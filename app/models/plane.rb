class Plane < ActiveRecord::Base
  validates :name, :type, :flight_type, :from_place, :to_place, presence: true
end
