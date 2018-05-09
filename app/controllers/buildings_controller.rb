class BuildingsController < ApplicationController
  before_action :authenticate_admin, only: [:new, :edit, :update, :destroy]
  before_action :set_building, only: [:show, :edit, :update, :destroy]

  # GET /buildings
  def index
    @buildings = Building.all.sort_by {|building| building.category}
    @categories = Category.all
  end

  # GET /buildings/1
  def show
  end

  # GET /buildings/new
  def new
    @building = Building.new
  end

  # GET /buildings/1/edit
  def edit
  end

  # POST /buildings
  def create
    @building = Building.new(building_params)

    if @building.save
      redirect_to @building, notice: 'Building was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /buildings/1
  def update
    if @building.update(building_params)
      redirect_to @building, notice: 'Building was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /buildings/1
  def destroy
    @building.destroy
    redirect_to buildings_url, notice: 'Building was successfully destroyed.'
  end

  private
  def set_building
    @building = Building.find(params[:id])
  end

  def building_params
    params.require(:building).permit(:category_id, :name, :inhabitants, :construction_duration_sec, :comment,
                                     :cost, :cost_per_hour, :income_per_hour, :required_building_id, :image)
  end
end
