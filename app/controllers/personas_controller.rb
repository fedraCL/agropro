class PersonasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_persona, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @personas = Persona.all
    respond_with(@personas)
  end

  def show
    respond_with(@persona)
  end

  def new
    @persona = Persona.new
    respond_with(@persona)
  end

  def edit
  end

  def create
    @persona = Persona.new(persona_params)
    @persona.save
    respond_with(@persona)
  end

  def update
    @persona.update(persona_params)
    respond_with(@persona)
  end

  def destroy
    @persona.destroy
    respond_with(@persona)
  end

  private
    def set_persona
      @persona = Persona.find(params[:id])
    end

    def persona_params
      params.require(:persona).permit(:rut, :dv, :tipo, :estado, :razonsocial, :alias, :nacionalidad, :direccion, :email, :contacto, :user)
    end
end
