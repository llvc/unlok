require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  setup do
    @contact = contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contacts)
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post :create, contact: { email: @contact.email, message: @contact.message, mobile: @contact.mobile, name: @contact.name, type: @contact.type }
    end

    assert_response 201
  end

  test "should show contact" do
    get :show, id: @contact
    assert_response :success
  end

  test "should update contact" do
    put :update, id: @contact, contact: { email: @contact.email, message: @contact.message, mobile: @contact.mobile, name: @contact.name, type: @contact.type }
    assert_response 204
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete :destroy, id: @contact
    end

    assert_response 204
  end
end
