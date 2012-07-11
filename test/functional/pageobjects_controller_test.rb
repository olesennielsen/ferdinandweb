require 'test_helper'

class PageobjectsControllerTest < ActionController::TestCase
  setup do
    @pageobject = pageobjects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pageobjects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pageobject" do
    assert_difference('Pageobject.count') do
      post :create, pageobject: @pageobject.attributes
    end

    assert_redirected_to pageobject_path(assigns(:pageobject))
  end

  test "should show pageobject" do
    get :show, id: @pageobject.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pageobject.to_param
    assert_response :success
  end

  test "should update pageobject" do
    put :update, id: @pageobject.to_param, pageobject: @pageobject.attributes
    assert_redirected_to pageobject_path(assigns(:pageobject))
  end

  test "should destroy pageobject" do
    assert_difference('Pageobject.count', -1) do
      delete :destroy, id: @pageobject.to_param
    end

    assert_redirected_to pageobjects_path
  end
end
