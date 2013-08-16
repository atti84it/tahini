class CustomUnitsController < ApplicationController
  before_action :set_custom_unit, only: [:show, :edit, :update, :destroy]

  # GET /custom_units
  # GET /custom_units.json
  def index
    @custom_units = CustomUnit.all
  end

  # GET /custom_units/1
  # GET /custom_units/1.json
  def show
  end

  # GET /custom_units/new
  def new
    @custom_unit = CustomUnit.new
  end

  # GET /custom_units/1/edit
  def edit
  end

  # POST /custom_units
  # POST /custom_units.json
  def create
    @custom_unit = CustomUnit.new(custom_unit_params)

    respond_to do |format|
      if @custom_unit.save
        format.html { redirect_to @custom_unit, notice: 'Custom unit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @custom_unit }
      else
        format.html { render action: 'new' }
        format.json { render json: @custom_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /custom_units/1
  # PATCH/PUT /custom_units/1.json
  def update
    respond_to do |format|
      if @custom_unit.update(custom_unit_params)
        format.html { redirect_to @custom_unit, notice: 'Custom unit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @custom_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /custom_units/1
  # DELETE /custom_units/1.json
  def destroy
    @custom_unit.destroy
    respond_to do |format|
      format.html { redirect_to custom_units_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_custom_unit
      @custom_unit = CustomUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def custom_unit_params
      params.require(:custom_unit).permit(:singular, :plural, :equivalence_unit, :equivalence_factor)
    end
end
