require 'test_helper'

class HqTasksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hq_tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hq_task" do
    assert_difference('HqTask.count') do
      post :create, :hq_task => { }
    end

    assert_redirected_to hq_task_path(assigns(:hq_task))
  end

  test "should show hq_task" do
    get :show, :id => hq_tasks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hq_tasks(:one).to_param
    assert_response :success
  end

  test "should update hq_task" do
    put :update, :id => hq_tasks(:one).to_param, :hq_task => { }
    assert_redirected_to hq_task_path(assigns(:hq_task))
  end

  test "should destroy hq_task" do
    assert_difference('HqTask.count', -1) do
      delete :destroy, :id => hq_tasks(:one).to_param
    end

    assert_redirected_to hq_tasks_path
  end
end
