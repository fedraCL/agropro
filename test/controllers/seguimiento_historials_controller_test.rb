require 'test_helper'

class SeguimientoHistorialsControllerTest < ActionController::TestCase
  setup do
    @seguimiento_historial = seguimiento_historials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seguimiento_historials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seguimiento_historial" do
    assert_difference('SeguimientoHistorial.count') do
      post :create, seguimiento_historial: { codigo: @seguimiento_historial.codigo, countchange: @seguimiento_historial.countchange, eta: @seguimiento_historial.eta, etd: @seguimiento_historial.etd, id_origen: @seguimiento_historial.id_origen, nave: @seguimiento_historial.nave, naviera: @seguimiento_historial.naviera, pod: @seguimiento_historial.pod, pol: @seguimiento_historial.pol, user: @seguimiento_historial.user }
    end

    assert_redirected_to seguimiento_historial_path(assigns(:seguimiento_historial))
  end

  test "should show seguimiento_historial" do
    get :show, id: @seguimiento_historial
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @seguimiento_historial
    assert_response :success
  end

  test "should update seguimiento_historial" do
    patch :update, id: @seguimiento_historial, seguimiento_historial: { codigo: @seguimiento_historial.codigo, countchange: @seguimiento_historial.countchange, eta: @seguimiento_historial.eta, etd: @seguimiento_historial.etd, id_origen: @seguimiento_historial.id_origen, nave: @seguimiento_historial.nave, naviera: @seguimiento_historial.naviera, pod: @seguimiento_historial.pod, pol: @seguimiento_historial.pol, user: @seguimiento_historial.user }
    assert_redirected_to seguimiento_historial_path(assigns(:seguimiento_historial))
  end

  test "should destroy seguimiento_historial" do
    assert_difference('SeguimientoHistorial.count', -1) do
      delete :destroy, id: @seguimiento_historial
    end

    assert_redirected_to seguimiento_historials_path
  end
end
