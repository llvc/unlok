class BookingsController < ApplicationController
  before_action :check_profile
  before_action :set_booking, only: [:show, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all

    render json: @bookings
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
    render json: @booking
  end

  def new
    @booking = Booking.new
    @domestic_locations = []
    Location.where(domestic: 'true').order(:airport_location).each do |location|
      @domestic_locations << [location.airport_location, location.airport_location]
    end

    @international_locations = []
    Location.where(domestic: 'false').order(:airport_location).each do |location|
      @international_locations << [location.airport_location, location.airport_location]
    end
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)

    puts "-----------------------------------------------"
    puts @booking.inspect
    puts "-----------------------------------------------"
    @booking.user_id = params[:booking][:user_id]

    if @booking.save
      UserMailer.booking_email(@booking).deliver_now
      UserMailer.booking_response_email(@booking).deliver_now
      redirect_to thankyou_bookings_path
      # redirect_to test_index_path
    else
      puts @booking.errors.inspect
      @domestic_locations = []
      Location.where(domestic: 'true').each do |location|
        @domestic_locations << [location.airport_location, location.airport_location]
      end

      @international_locations = []
      Location.where(domestic: 'false').each do |location|
        @international_locations << [location.airport_location, location.airport_location]
      end
      render :new
    end
  end

  def thankyou
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    @booking = Booking.find(params[:id])

    if @booking.update(booking_params)
      head :no_content
    else
      render json: @booking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy

    head :no_content
  end

  def indicator
  end

  private

    def set_booking
      @booking = Booking.find(params[:id])
    end

    def check_profile
      if current_user.profile.nil?
        flash[:success] = "Please update your profile before booking"
     redirect_to '/profile'
   elsif current_user.profile.name.blank?
    flash[:success] = "Please update your name before booking"
     redirect_to '/profile'
   elsif current_user.mobile_number.blank?
    flash[:success] = "Please update your mobile number before booking"
     redirect_to '/profile'
        elsif current_user.email.blank?
    flash[:success] = "Please update your email before booking"
     redirect_to '/profile'
    end

    end

    def booking_params
      params.require(:booking).permit(:name, :type, :flight_type, :from_place, :to_place, 
                                      :date_of_journey, :noofpassengers, :from_location, 
                                      :to_location, :user_id, :aircraft_type,:trip_type, 
                                      :oneway_trip, :quantity, :item_id, :bookable_type, 
                                      :message, :invoice_number,:tripdate,:triptime).merge(user_id: params[:booking][:user_id])
    end
end
