require 'test_helper'

class HqVserversControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_vservers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_vserver" do
    assert_difference('HqVserver.count') do
      post :create, :hq_vserver => { }
    end

    assert_redirected_to hq_vserver_path(assigns(:hq_vserver))
  end

  test "should show hq_vserver" do
    get :show, :id => hq_vservers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_vservers(:one).to_param
    assert_response :success
  end

  test "should update hq_vserver" do
    put :update, :id => hq_vservers(:one).to_param, :hq_vserver => { }
    assert_redirected_to hq_vserver_path(assigns(:hq_vserver))
  end

  test "should destroy hq_vserver" do
    assert_difference('HqVserver.count', -1) do
      delete :destroy, :id => hq_vservers(:one).to_param
    end

    assert_redirected_to hq_vservers_path
  end
end
