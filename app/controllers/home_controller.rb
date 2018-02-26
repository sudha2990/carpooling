class HomeController < ApplicationController
  def index
  	@ride = Ride.new
  end
end
