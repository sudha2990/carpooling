class RidesController < ApplicationController
  before_action :authenticate_user! , except: [:index, :show, :search]
  before_action :set_ride, only: [:show, :edit, :update, :destroy, :join]

  # GET /rides
  # GET /rides.json
  def index
    @rides = Ride.find_user_rides(current_user)
  end

  # GET /rides/1
  # GET /rides/1.json
  def show
  end

  # GET /rides/new
  def new
    @ride = Ride.new
  end

  # GET /rides/1/edit
  def edit
  end

  # POST /rides
  # POST /rides.json
  def create
    @ride = current_user.rides.build(ride_params)
    respond_to do |format|
      if @ride.save
        format.html { redirect_to @ride, notice: 'Ride was successfully created.' }
        format.json { render :show, status: :created, location: @ride }
      else
        format.html { render :new }
        format.json { render json: @ride.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rides/1
  # PATCH/PUT /rides/1.json
  def update
    unless current_user.is_owner?(@ride)
      flash[:error] = "You do not have the required permissions to perform this action"
      redirect_to root_path
    end
    respond_to do |format|
      if @ride.update(ride_params)
        format.html { redirect_to @ride, notice: 'Ride was successfully updated.' }
        format.json { render :show, status: :ok, location: @ride }
      else
        format.html { render :edit }
        format.json { render json: @ride.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rides/1
  # DELETE /rides/1.json
  def destroy
    
    if current_user.is_owner?(@ride)
      @ride.destroy
      respond_to do |format|
        format.html { redirect_to rides_url, notice: 'Ride was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      flash[:error] = "You do not have the required permissions to perform this action"
    end
  end

  def search
    ride_param = params[:ride] if params[:ride].present?
    @rides = []
    if(ride_params[:source] != "")
      @rides = Ride.where(:source=>ride_params[:source])
    end
    if(ride_params[:destination] != "")
      @rides = Ride.where(:destination=>ride_params[:destination])
    end
    if (ride_params[:destination] != "" && ride_params[:source] != "")
      @rides = Ride.where(:source=>ride_params[:source]).where(:destination=>ride_params[:destination]).first
    end
    if (ride_params[:destination] == "" && ride_params[:source] == "")
      @rides = Ride.all
    end
    @rides.select {|ride| ride.seats > (ride.travellers.count + 1)}
  end

  def join
    @ride.travellers << current_user.id
    if @ride.save
      flash[:notice] = "Congratulations you have been added to ride"
      redirect_to ride_path(@ride)
    else
      flash[:error] = "Sorry could not be added to ride."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ride
      @ride = Ride.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ride_params
      params[:ride].permit(:source,:destination,:cost,:departure_time,:arrival_time,:route,:travellers,:user_id, :start_date, :seats)
    end
end
