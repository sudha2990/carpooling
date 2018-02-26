class Traveller < ActiveRecord::Base
	belongs_to :ride
	belongs_to :car
end
