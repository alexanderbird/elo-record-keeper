class GametypesController < ApplicationController
  before_action :set_gametype, only: [:show, :edit, :update, :destroy]

  # GET /gametypes
  # GET /gametypes.json
  def index
    @gametypes = Gametype.all
  end

  # GET /gametypes/1
  # GET /gametypes/1.json
  def show
  end

  # GET /gametypes/new
  def new
    @gametype = Gametype.new
  end

  # GET /gametypes/1/edit
  def edit
  end

  # POST /gametypes
  # POST /gametypes.json
  def create
    @gametype = Gametype.new(gametype_params)

    respond_to do |format|
      if @gametype.save
        format.html { redirect_to @gametype, notice: 'Gametype was successfully created.' }
        format.json { render action: 'show', status: :created, location: @gametype }
      else
        format.html { render action: 'new' }
        format.json { render json: @gametype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gametypes/1
  # PATCH/PUT /gametypes/1.json
  def update
    respond_to do |format|
      if @gametype.update(gametype_params)
        format.html { redirect_to @gametype, notice: 'Gametype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @gametype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gametypes/1
  # DELETE /gametypes/1.json
  def destroy
    @gametype.destroy
    respond_to do |format|
      format.html { redirect_to gametypes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gametype
      @gametype = Gametype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gametype_params
      params.require(:gametype).permit(:name, :number_of_teams, :players_per_team)
    end
end
