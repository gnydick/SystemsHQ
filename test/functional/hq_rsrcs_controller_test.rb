require 'test_helper'

class HqRsrcsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_rsrcs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_rsrc" do
    assert_difference('HqRsrc.count') do
      post :create, :hq_rsrc => { }
    end

    assert_redirected_to hq_rsrc_path(assigns(:hq_rsrc))
  end

  test "should show hq_rsrc" do
    get :show, :id => hq_rsrcs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_rsrcs(:one).to_param
    assert_response :success
  end

  test "should update hq_rsrc" do
    put :update, :id => hq_rsrcs(:one).to_param, :hq_rsrc => { }
    assert_redirected_to hq_rsrc_path(assigns(:hq_rsrc))
  end

  test "should destroy hq_rsrc" do
    assert_difference('HqRsrc.count', -1) do
      delete :destroy, :id => hq_rsrcs(:one).to_param
    end

    assert_redirected_to hq_rsrcs_path
  end
end
