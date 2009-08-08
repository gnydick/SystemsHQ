require 'test_helper'

class HqSwitchesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_switches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_switch" do
    assert_difference('HqSwitch.count') do
      post :create, :hq_switch => { }
    end

    assert_redirected_to hq_switch_path(assigns(:hq_switch))
  end

  test "should show hq_switch" do
    get :show, :id => hq_switches(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_switches(:one).to_param
    assert_response :success
  end

  test "should update hq_switch" do
    put :update, :id => hq_switches(:one).to_param, :hq_switch => { }
    assert_redirected_to hq_switch_path(assigns(:hq_switch))
  end

  test "should destroy hq_switch" do
    assert_difference('HqSwitch.count', -1) do
      delete :destroy, :id => hq_switches(:one).to_param
    end

    assert_redirected_to hq_switches_path
  end
end
