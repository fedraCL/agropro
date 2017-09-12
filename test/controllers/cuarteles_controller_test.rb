require 'test_helper'

class CuartelesControllerTest < ActionController::TestCase
  setup do
    @cuartele = cuarteles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cuarteles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cuartele" do
    assert_difference('Cuartele.count') do
      post :create, cuartele: { nombre: @cuartele.nombre }
    end

    assert_redirected_to cuartele_path(assigns(:cuartele))
  end

  test "should show cuartele" do
    get :show, id: @cuartele
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cuartele
    assert_response :success
  end

  test "should update cuartele" do
    patch :update, id: @cuartele, cuartele: { nombre: @cuartele.nombre }
    assert_redirected_to cuartele_path(assigns(:cuartele))
  end

  test "should destroy cuartele" do
    assert_difference('Cuartele.count', -1) do
      delete :destroy, id: @cuartele
    end

    assert_redirected_to cuarteles_path
  end
end
