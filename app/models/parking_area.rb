# Class ParkingArea is responsible for creating parking area with given capacity.

class ParkingArea < ActiveRecord::Base

  validates :capacity,
            :presence => true,
            :numericality => true

end
