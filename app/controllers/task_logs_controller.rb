class TaskLogsController < ApplicationController
  before_action :set_task_log, only: [:show, :edit, :update, :destroy]

  # GET /task_logs
  def index
    @task_logs = TaskLog.all.order(:id)
  end

  # GET /task_logs/1
  def show
  end

  # GET /task_logs/new
  def new
    @task_log = TaskLog.new
  end

  # GET /task_logs/1/edit
  def edit
  end

  def add
    if params[:group] == 'all'
      game = Game.find(params[:game])
      game.groups.each do |group|
        create_task_log(params, group.id)
      end
    else
      create_task_log(params, params[:group])
    end
    redirect_to game_path(params[:game])
  end

  # POST /task_logs
  def create
    @task_log = TaskLog.new(task_log_params)

    if @task_log.save
      redirect_to @task_log, notice: 'Task log was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /task_logs/1
  def update
    unless params[:task_log].nil? && params[:task_log][:done].nil?
      set_end_to_now
    end
    @task_log.update(task_log_params)
  end

  # DELETE /task_logs/1
  def destroy
    @task_log.destroy
    redirect_back fallback_location: root_path, notice: 'Task log was successfully destroyed.'
  end

  def start
    task_log = TaskLog.find(params[:task_log_id])
    if task_log.start.nil?
      task_log.start = DateTime.now
      task_log.save!
      redirect_back fallback_location: root_path, notice: 'Task log was successfully started.'
    else
      redirect_back fallback_location: root_path, alert: 'Task log was already started.'
    end

  end

  private
  def create_task_log(params, group_id)
    task_log = TaskLog.new(
        task: Task.find(params[:task]),
        group_id: group_id,
        start: nil,
        comment: '',
        done: false
    )
    task_log.save
  end

  def set_task_log
    @task_log = TaskLog.find(params[:id])
  end

  def task_log_params
    params.require(:task_log).permit(:task_id, :group_id, :start, :end, :comment, :done)
  end

  def set_end_to_now
    if params[:task_log][:done] == 'true'
      params[:task_log][:end] = DateTime.now
    else
      params[:task_log][:end] = nil
    end
  end
end
