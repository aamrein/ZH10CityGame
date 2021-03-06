class ConstructedBuildingsController < ApplicationController
  before_action :set_group, only: [:index, :create, :destroy]
  before_action :set_constructed_building, only: [:destroy]

  # GET /constructed_buildings
  def index
    @constructed_buildings = ConstructedBuilding.where(group: params[:group_id])
  end

  # POST /constructed_buildings
  def create
    building = Building.find(params[:building_id])
    unless building.nil?
      if @game.is_running? && @group.can_build?(building.cost)
        @constructed_building = ConstructedBuilding.new(constructed_building_params)
        if @constructed_building.save
          return redirect_back(fallback_location: group_path(@group), notice: "#{@constructed_building.building.name} #{t(:under_construction)}.")
        end
      end
      return redirect_back(fallback_location: group_path(@group), alert: "#{building.name} #{t(:cant_build)}.")
    end
    redirect_back(fallback_location: group_path(@group), alert: "#{params[:building_id]} #{t(:cant_build)}.")
  end

  # DELETE /constructed_buildings/1
  def destroy
    if @constructed_building.under_construction || current_user.admin?
      building_name = @constructed_building.building.name
      @constructed_building.destroy
      redirect_to group_path(@group), notice: "Das Gebäude '#{building_name}' wurde abgebrochen."
    else
      redirect_to group_path(@group), alert: 'Das Gebäude kann nicht zerstört werden, da es bereits fertig gebaut ist.'
    end
  end

  private
  def set_group
    @group = Group.find(params[:group_id])
    @game = Game.find(@group.game_id) unless @group.nil?
  end

  def set_constructed_building
    @constructed_building = ConstructedBuilding.find(params[:id])
  end

  def constructed_building_params
    {group_id: params[:group_id], building_id: params[:building_id], construction_time: DateTime.now()}
  end
end
