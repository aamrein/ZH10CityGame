class EventLogsController < ApplicationController
  before_action :set_vars, only: [:index, :show, :edit, :update]
  before_action :set_event_log, only: [:show, :edit, :update, :destroy]

  # GET /event_logs
  def index
    @event_logs = EventLog.all
  end

  # GET /event_logs/1
  def show
  end

  # GET /event_logs/new
  def new
    @event_log = EventLog.new
  end

  def add
    p params
    game = Game.find(params[:game])
    if params[:group] == 'all'
      game.groups.each do |group|
        create_event_log(params, group)
      end
    else
      create_event_log(params, params[:group])
    end
    redirect_to game_path(params[:game])
  end

  # GET /event_logs/1/edit
  def edit
  end

  # POST /event_logs
  def create
    @event_log = EventLog.new(event_log_params)

    if @event_log.save
      redirect_to @event_log, notice: 'Event log was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /event_logs/1
  def update
    if @event_log.update(event_log_params)
      redirect_to @event_log, notice: 'Event log was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /event_logs/1
  def destroy
    @event_log.destroy
    redirect_to event_logs_url, notice: 'Event log was successfully destroyed.'
  end

  private
  def create_event_log(params, group)
    constructed_building = ConstructedBuilding.find_by(group_id: group)
    unless constructed_building.nil? && !constructed_building.under_construction
      event_log = EventLog.new(
          constructed_building: constructed_building,
          event_id: params[:event].to_i,
          start: DateTime.now)
      return event_log.save!
    end
    false
  end

  def set_vars
    @constructed_building = ConstructedBuilding.find(params[:constructed_building_id])
    @group = @constructed_building.group unless @constructed_building.nil?
  end

  def set_event_log
    @event_log = EventLog.find(params[:id])
  end

  def event_log_params
    params.require(:event_log).permit(:constructed_building_id, :event_id, :start, :comment)
  end
end
