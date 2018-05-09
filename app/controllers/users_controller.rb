class UsersController < ApplicationController
  before_action :authenticate_admin
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :set_groups, only: [:edit, :update]

  # GET /accountings
  def index
    @users = User.all
  end

  # GET /accountings/1/edit
  def edit
  end

  # PATCH/PUT /accountings/1
  def update
    if @user.update(user_params)
      redirect_to users_path, notice: t(:user_was_successfully_updated)
    else
      render :edit
    end
  end

  # DELETE /accountings/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def set_groups
      @groups = Group.all.order(:name)
    end

    def user_params
      params.require(:user).permit(:group_id)
    end
end
