require 'test_helper'

class HqNicsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_nics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_nic" do
    assert_difference('HqNic.count') do
      post :create, :hq_nic => { }
    end

    assert_redirected_to hq_nic_path(assigns(:hq_nic))
  end

  test "should show hq_nic" do
    get :show, :id => hq_nics(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_nics(:one).to_param
    assert_response :success
  end

  test "should update hq_nic" do
    put :update, :id => hq_nics(:one).to_param, :hq_nic => { }
    assert_redirected_to hq_nic_path(assigns(:hq_nic))
  end

  test "should destroy hq_nic" do
    assert_difference('HqNic.count', -1) do
      delete :destroy, :id => hq_nics(:one).to_param
    end

    assert_redirected_to hq_nics_path
  end
end
