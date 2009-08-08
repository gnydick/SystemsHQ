require 'test_helper'

class HqServersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_servers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_server" do
    assert_difference('HqServer.count') do
      post :create, :hq_server => { }
    end

    assert_redirected_to hq_server_path(assigns(:hq_server))
  end

  test "should show hq_server" do
    get :show, :id => hq_servers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_servers(:one).to_param
    assert_response :success
  end

  test "should update hq_server" do
    put :update, :id => hq_servers(:one).to_param, :hq_server => { }
    assert_redirected_to hq_server_path(assigns(:hq_server))
  end

  test "should destroy hq_server" do
    assert_difference('HqServer.count', -1) do
      delete :destroy, :id => hq_servers(:one).to_param
    end

    assert_redirected_to hq_servers_path
  end
end
