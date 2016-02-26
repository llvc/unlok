require 'test_helper'

class BookingsControllerTest < ActionController::TestCase
  setup do
    @booking = bookings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookings)
  end

  test "should create booking" do
    assert_difference('Booking.count') do
      post :create, booking: { date_of_journey: @booking.date_of_journey, flight_type: @booking.flight_type, from_place: @booking.from_place, name: @booking.name, noofpassengers: @booking.noofpassengers, to_place: @booking.to_place, type: @booking.type }
    end

    assert_response 201
  end

  test "should show booking" do
    get :show, id: @booking
    assert_response :success
  end

  test "should update booking" do
    put :update, id: @booking, booking: { date_of_journey: @booking.date_of_journey, flight_type: @booking.flight_type, from_place: @booking.from_place, name: @booking.name, noofpassengers: @booking.noofpassengers, to_place: @booking.to_place, type: @booking.type }
    assert_response 204
  end

  test "should destroy booking" do
    assert_difference('Booking.count', -1) do
      delete :destroy, id: @booking
    end

    assert_response 204
  end
end
