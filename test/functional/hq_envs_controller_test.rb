require 'test_helper'

class HqEnvsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_envs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_env" do
    assert_difference('HqEnv.count') do
      post :create, :hq_env => { }
    end

    assert_redirected_to hq_env_path(assigns(:hq_env))
  end

  test "should show hq_env" do
    get :show, :id => hq_envs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_envs(:one).to_param
    assert_response :success
  end

  test "should update hq_env" do
    put :update, :id => hq_envs(:one).to_param, :hq_env => { }
    assert_redirected_to hq_env_path(assigns(:hq_env))
  end

  test "should destroy hq_env" do
    assert_difference('HqEnv.count', -1) do
      delete :destroy, :id => hq_envs(:one).to_param
    end

    assert_redirected_to hq_envs_path
  end
end
