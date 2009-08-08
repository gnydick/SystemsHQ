require 'test_helper'

class HqAppsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_apps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_app" do
    assert_difference('HqApp.count') do
      post :create, :hq_app => { }
    end

    assert_redirected_to hq_app_path(assigns(:hq_app))
  end

  test "should show hq_app" do
    get :show, :id => hq_apps(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_apps(:one).to_param
    assert_response :success
  end

  test "should update hq_app" do
    put :update, :id => hq_apps(:one).to_param, :hq_app => { }
    assert_redirected_to hq_app_path(assigns(:hq_app))
  end

  test "should destroy hq_app" do
    assert_difference('HqApp.count', -1) do
      delete :destroy, :id => hq_apps(:one).to_param
    end

    assert_redirected_to hq_apps_path
  end
end
