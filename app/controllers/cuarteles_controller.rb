class CuartelesController < ApplicationController
  before_action :set_cuartele, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @cuarteles = Cuartele.all
    respond_with(@cuarteles)
  end

  def show
    respond_with(@cuartele)
  end

  def new
    @cuartele = Cuartele.new
    respond_with(@cuartele)
  end

  def edit
  end

  def create
    @cuartele = Cuartele.new(cuartele_params)
    @cuartele.save
    respond_with(@cuartele)
  end

  def update
    @cuartele.update(cuartele_params)
    respond_with(@cuartele)
  end

  def destroy
    @cuartele.destroy
    respond_with(@cuartele)
  end

  private
    def set_cuartele
      @cuartele = Cuartele.find(params[:id])
    end

    def cuartele_params
      params.require(:cuartele).permit(:nombre)
    end
end
