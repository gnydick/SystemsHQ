require 'test_helper'

class HqRacksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_racks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_rack" do
    assert_difference('HqRack.count') do
      post :create, :hq_rack => { }
    end

    assert_redirected_to hq_rack_path(assigns(:hq_rack))
  end

  test "should show hq_rack" do
    get :show, :id => hq_racks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_racks(:one).to_param
    assert_response :success
  end

  test "should update hq_rack" do
    put :update, :id => hq_racks(:one).to_param, :hq_rack => { }
    assert_redirected_to hq_rack_path(assigns(:hq_rack))
  end

  test "should destroy hq_rack" do
    assert_difference('HqRack.count', -1) do
      delete :destroy, :id => hq_racks(:one).to_param
    end

    assert_redirected_to hq_racks_path
  end
end
