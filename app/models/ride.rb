class Ride < ActiveRecord::Base
	belongs_to :owner, :class_name => 'User'
	has_one :car
	validates_presence_of :source, :destination, :arrival_time, :cost, :departure_time, :start_date

	def self.find_user_rides(current_user) 
		user_rides = current_user.rides
		user_rides << Ride.all.select {|ride| ride.travellers.include?(current_user.id)}
		user_rides
	end
end
