require 'test_helper'

class PersonasControllerTest < ActionController::TestCase
  setup do
    @persona = personas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:personas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create persona" do
    assert_difference('Persona.count') do
      post :create, persona: { alias: @persona.alias, contacto: @persona.contacto, direccion: @persona.direccion, dv: @persona.dv, email: @persona.email, estado: @persona.estado, nacionalidad: @persona.nacionalidad, razonsocial: @persona.razonsocial, rut: @persona.rut, tipo: @persona.tipo, user: @persona.user }
    end

    assert_redirected_to persona_path(assigns(:persona))
  end

  test "should show persona" do
    get :show, id: @persona
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @persona
    assert_response :success
  end

  test "should update persona" do
    patch :update, id: @persona, persona: { alias: @persona.alias, contacto: @persona.contacto, direccion: @persona.direccion, dv: @persona.dv, email: @persona.email, estado: @persona.estado, nacionalidad: @persona.nacionalidad, razonsocial: @persona.razonsocial, rut: @persona.rut, tipo: @persona.tipo, user: @persona.user }
    assert_redirected_to persona_path(assigns(:persona))
  end

  test "should destroy persona" do
    assert_difference('Persona.count', -1) do
      delete :destroy, id: @persona
    end

    assert_redirected_to personas_path
  end
end
