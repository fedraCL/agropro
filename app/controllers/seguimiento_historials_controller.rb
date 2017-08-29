class SeguimientoHistorialsController < ApplicationController
  before_action :set_seguimiento_historial, only: [:show, :edit, :update, :destroy]

  # GET /seguimiento_historials
  # GET /seguimiento_historials.json
  def index
    @seguimiento_historials = SeguimientoHistorial.all
  end

  # GET /seguimiento_historials/1
  # GET /seguimiento_historials/1.json
  def show
  end

  # GET /seguimiento_historials/new
  def new
    @seguimiento_historial = SeguimientoHistorial.new
  end

  # GET /seguimiento_historials/1/edit
  def edit
  end

  # POST /seguimiento_historials
  # POST /seguimiento_historials.json
  def create
    @seguimiento_historial = SeguimientoHistorial.new(seguimiento_historial_params)

    respond_to do |format|
      if @seguimiento_historial.save
        format.html { redirect_to @seguimiento_historial, notice: 'Seguimiento historial was successfully created.' }
        format.json { render action: 'show', status: :created, location: @seguimiento_historial }
      else
        format.html { render action: 'new' }
        format.json { render json: @seguimiento_historial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /seguimiento_historials/1
  # PATCH/PUT /seguimiento_historials/1.json
  def update
    respond_to do |format|
      if @seguimiento_historial.update(seguimiento_historial_params)
        format.html { redirect_to @seguimiento_historial, notice: 'Seguimiento historial was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @seguimiento_historial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seguimiento_historials/1
  # DELETE /seguimiento_historials/1.json
  def destroy
    @seguimiento_historial.destroy
    respond_to do |format|
      format.html { redirect_to seguimiento_historials_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_seguimiento_historial
      @seguimiento_historial = SeguimientoHistorial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def seguimiento_historial_params
      params.require(:seguimiento_historial).permit(:id_origen, :codigo, :naviera, :nave, :pol, :pod, :etd, :eta, :countchange, :user)
    end
end
