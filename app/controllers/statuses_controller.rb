class StatusesController < ApplicationController
  before_filter :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  
  # GET /statuses
  # GET /statuses.json
  def index
    @statuses = Status.all
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
    set_status
  end

  # GET /statuses/new
  def new
    @status = Status.new
  end

  # GET /statuses/1/edit
  def edit
    set_status
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = current_user.statuses.new(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to @status, notice: 'Status was successfully created.' }
        format.json { render action: 'show', status: :created, location: @status }
      else
        format.html { render action: 'new' }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update
    @status = current_user.statuses.find(params[:id])
    if (params[:status])
      params[:status].delete(:user_id) if params[:status].has_key?(:user_id)
    end

    respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to @status, notice: 'Status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    set_status
    @status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      if (params[:status])
        params.require(:status).permit(:name, :content, :user_id)
      end
    end
  end