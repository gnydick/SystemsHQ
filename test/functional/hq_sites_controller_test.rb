require 'test_helper'

class HqSitesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_sites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_sites" do
    assert_difference('HqSites.count') do
      post :create, :hq_sites => { }
    end

    assert_redirected_to hq_sites_path(assigns(:hq_sites))
  end

  test "should show hq_sites" do
    get :show, :id => hq_sites(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_sites(:one).to_param
    assert_response :success
  end

  test "should update hq_sites" do
    put :update, :id => hq_sites(:one).to_param, :hq_sites => { }
    assert_redirected_to hq_sites_path(assigns(:hq_sites))
  end

  test "should destroy hq_sites" do
    assert_difference('HqSites.count', -1) do
      delete :destroy, :id => hq_sites(:one).to_param
    end

    assert_redirected_to hq_sites_path
  end
end
