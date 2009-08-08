require 'test_helper'

class HqCagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_cages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_cage" do
    assert_difference('HqCage.count') do
      post :create, :hq_cage => { }
    end

    assert_redirected_to hq_cage_path(assigns(:hq_cage))
  end

  test "should show hq_cage" do
    get :show, :id => hq_cages(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_cages(:one).to_param
    assert_response :success
  end

  test "should update hq_cage" do
    put :update, :id => hq_cages(:one).to_param, :hq_cage => { }
    assert_redirected_to hq_cage_path(assigns(:hq_cage))
  end

  test "should destroy hq_cage" do
    assert_difference('HqCage.count', -1) do
      delete :destroy, :id => hq_cages(:one).to_param
    end

    assert_redirected_to hq_cages_path
  end
end
