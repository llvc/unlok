require 'test_helper'

class EmptylegsControllerTest < ActionController::TestCase
  setup do
    @emptyleg = emptylegs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emptylegs)
  end

  test "should create emptyleg" do
    assert_difference('Emptyleg.count') do
      post :create, emptyleg: { aircraft_type: @emptyleg.aircraft_type, departon: @emptyleg.departon, from: @emptyleg.from, min_price: @emptyleg.min_price, price: @emptyleg.price, seats: @emptyleg.seats, to: @emptyleg.to }
    end

    assert_response 201
  end

  test "should show emptyleg" do
    get :show, id: @emptyleg
    assert_response :success
  end

  test "should update emptyleg" do
    put :update, id: @emptyleg, emptyleg: { aircraft_type: @emptyleg.aircraft_type, departon: @emptyleg.departon, from: @emptyleg.from, min_price: @emptyleg.min_price, price: @emptyleg.price, seats: @emptyleg.seats, to: @emptyleg.to }
    assert_response 204
  end

  test "should destroy emptyleg" do
    assert_difference('Emptyleg.count', -1) do
      delete :destroy, id: @emptyleg
    end

    assert_response 204
  end
end
