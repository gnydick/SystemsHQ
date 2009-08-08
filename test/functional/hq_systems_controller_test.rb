require 'test_helper'

class HqSystemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_systems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_system" do
    assert_difference('HqSystem.count') do
      post :create, :hq_system => { }
    end

    assert_redirected_to hq_system_path(assigns(:hq_system))
  end

  test "should show hq_system" do
    get :show, :id => hq_systems(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_systems(:one).to_param
    assert_response :success
  end

  test "should update hq_system" do
    put :update, :id => hq_systems(:one).to_param, :hq_system => { }
    assert_redirected_to hq_system_path(assigns(:hq_system))
  end

  test "should destroy hq_system" do
    assert_difference('HqSystem.count', -1) do
      delete :destroy, :id => hq_systems(:one).to_param
    end

    assert_redirected_to hq_systems_path
  end
end
