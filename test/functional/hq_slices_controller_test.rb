require 'test_helper'

class HqSlicesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_slices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_slice" do
    assert_difference('HqSlice.count') do
      post :create, :hq_slice => { }
    end

    assert_redirected_to hq_slice_path(assigns(:hq_slice))
  end

  test "should show hq_slice" do
    get :show, :id => hq_slices(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_slices(:one).to_param
    assert_response :success
  end

  test "should update hq_slice" do
    put :update, :id => hq_slices(:one).to_param, :hq_slice => { }
    assert_redirected_to hq_slice_path(assigns(:hq_slice))
  end

  test "should destroy hq_slice" do
    assert_difference('HqSlice.count', -1) do
      delete :destroy, :id => hq_slices(:one).to_param
    end

    assert_redirected_to hq_slices_path
  end
end
