require 'test_helper'

class HqRsrcUsagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_rsrc_usages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_rsrc_usage" do
    assert_difference('HqRsrcUsage.count') do
      post :create, :hq_rsrc_usage => { }
    end

    assert_redirected_to hq_rsrc_usage_path(assigns(:hq_rsrc_usage))
  end

  test "should show hq_rsrc_usage" do
    get :show, :id => hq_rsrc_usages(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_rsrc_usages(:one).to_param
    assert_response :success
  end

  test "should update hq_rsrc_usage" do
    put :update, :id => hq_rsrc_usages(:one).to_param, :hq_rsrc_usage => { }
    assert_redirected_to hq_rsrc_usage_path(assigns(:hq_rsrc_usage))
  end

  test "should destroy hq_rsrc_usage" do
    assert_difference('HqRsrcUsage.count', -1) do
      delete :destroy, :id => hq_rsrc_usages(:one).to_param
    end

    assert_redirected_to hq_rsrc_usages_path
  end
end
