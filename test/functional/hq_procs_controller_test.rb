require 'test_helper'

class HqProcsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_procs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_proc" do
    assert_difference('HqProc.count') do
      post :create, :hq_proc => { }
    end

    assert_redirected_to hq_proc_path(assigns(:hq_proc))
  end

  test "should show hq_proc" do
    get :show, :id => hq_procs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_procs(:one).to_param
    assert_response :success
  end

  test "should update hq_proc" do
    put :update, :id => hq_procs(:one).to_param, :hq_proc => { }
    assert_redirected_to hq_proc_path(assigns(:hq_proc))
  end

  test "should destroy hq_proc" do
    assert_difference('HqProc.count', -1) do
      delete :destroy, :id => hq_procs(:one).to_param
    end

    assert_redirected_to hq_procs_path
  end
end
