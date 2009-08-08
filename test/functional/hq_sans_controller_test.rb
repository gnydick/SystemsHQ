require 'test_helper'

class HqSansControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_sans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_san" do
    assert_difference('HqSan.count') do
      post :create, :hq_san => { }
    end

    assert_redirected_to hq_san_path(assigns(:hq_san))
  end

  test "should show hq_san" do
    get :show, :id => hq_sans(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_sans(:one).to_param
    assert_response :success
  end

  test "should update hq_san" do
    put :update, :id => hq_sans(:one).to_param, :hq_san => { }
    assert_redirected_to hq_san_path(assigns(:hq_san))
  end

  test "should destroy hq_san" do
    assert_difference('HqSan.count', -1) do
      delete :destroy, :id => hq_sans(:one).to_param
    end

    assert_redirected_to hq_sans_path
  end
end
