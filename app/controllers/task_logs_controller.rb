class TaskLogsController < ApplicationController
  before_action :set_task_log, only: [:show, :edit, :update, :destroy]

  # GET /task_logs
  def index
    @task_logs = TaskLog.all
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
    p params
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
    if @task_log.update(task_log_params)
      redirect_to @task_log, notice: 'Task log was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /task_logs/1
  def destroy
    @task_log.destroy
    redirect_to task_logs_url, notice: 'Task log was successfully destroyed.'
  end

  private
  def create_task_log(params, group_id)
    task_log = TaskLog.new(
        task: Task.find(params[:task]),
        group_id: group_id,
        start: DateTime.now,
        comment: '',
        done: false
    )
    task_log.save
  end

  def set_task_log
    @task_log = TaskLog.find(params[:id])
  end

  def task_log_params
    params.require(:task_log).permit(:task_id, :group_id, :start, :comment, :done)
  end
end
