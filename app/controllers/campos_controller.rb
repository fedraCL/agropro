class CamposController < ApplicationController
  before_action :set_campo, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @campos = Campo.all
    respond_with(@campos)
  end

  def show
    respond_with(@campo)
  end

  def new
    @campo = Campo.new
    respond_with(@campo)
  end

  def edit
  end

  def create
    @campo = Campo.new(campo_params)
    @campo.save
    respond_with(@campo)
  end

  def update
    @campo.update(campo_params)
    respond_with(@campo)
  end

  def destroy
    @campo.destroy
    respond_with(@campo)
  end

  private
    def set_campo
      @campo = Campo.find(params[:id])
    end

    def campo_params
      params.require(:campo).permit(:nombre)
    end
end
