require 'test_helper'

class HqDiskarraysControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_diskarrays)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_diskarray" do
    assert_difference('HqDiskarray.count') do
      post :create, :hq_diskarray => { }
    end

    assert_redirected_to hq_diskarray_path(assigns(:hq_diskarray))
  end

  test "should show hq_diskarray" do
    get :show, :id => hq_diskarrays(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_diskarrays(:one).to_param
    assert_response :success
  end

  test "should update hq_diskarray" do
    put :update, :id => hq_diskarrays(:one).to_param, :hq_diskarray => { }
    assert_redirected_to hq_diskarray_path(assigns(:hq_diskarray))
  end

  test "should destroy hq_diskarray" do
    assert_difference('HqDiskarray.count', -1) do
      delete :destroy, :id => hq_diskarrays(:one).to_param
    end

    assert_redirected_to hq_diskarrays_path
  end
end
