class GroupsController < ApplicationController
  before_action :authenticate_admin, only: [:new, :edit, :update, :destroy]
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :set_games, only: [:edit, :update, :new]

  # GET /groups
  def index
    if current_user.admin?
      @groups = Group.all
    else
      unless current_user.group.nil?
        redirect_to group_path(current_user.group)
      end
    end
    respond_to do |format|
      format.html
      format.json { render json: @groups, except: [:created_at, :updated_at], methods: [:balance, :points] }
    end
  end

  # GET /groups/1
  def show
    unless current_user.admin? || current_user.group.id == params[:id].to_i
      redirect_to groups_path
    end
    respond_to do |format|
      format.html
      format.json { render json: @group, only: :id, methods: [:balance, :points] }
    end
  end

  # GET /groups/new
  def new
    @group = Group.new @game
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to @group, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /groups/1
  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'Group was successfully destroyed.'
  end

  private
  def set_group
    @group = Group.find(params[:id])
    @game = Game.find(@group.game_id) unless @group.nil?
    @buildings = Building.all
  end

  def set_games
    @games = Game.all
  end

  def group_params
    params.require(:group).permit(:game_id, :name, :email, :phone, :start_balance, :comment)
  end

  def authenticate_admin
    unless (current_user && current_user.admin?)
      redirect_to root_path, alert: t(:not_authorized)
    end
  end
end
