class AccountingsController < ApplicationController
  before_action :authenticate_admin
  before_action :set_accounting, only: [:edit, :update, :destroy]
  before_action :set_group, only: [:edit, :update, :new, :create]

  # GET /accountings
  def index
    @accountings = Accounting.all
  end

  # GET /accountings/new
  def new
    @accounting = Accounting.new
  end

  # GET /accountings/1/edit
  def edit
  end

  # POST /accountings
  def create
    @accounting = Accounting.new(accounting_params)

    if @accounting.save
      redirect_to accountings_path, notice: t(:accounting_was_successfully_created)
    else
      render :new
    end
  end

  # PATCH/PUT /accountings/1
  def update
    if @accounting.update(accounting_params)
      redirect_to accountings_path, notice: t(:accounting_was_successfully_updated)
    else
      render :edit
    end
  end

  # DELETE /accountings/1
  def destroy
    @accounting.destroy
    redirect_to accountings_url, notice: 'Accounting was successfully destroyed.'
  end

  private
    def set_accounting
      @accounting = Accounting.find(params[:id])
    end

    def set_group
      @groups = Group.all.order(:name)
    end

    def accounting_params
      params.require(:accounting).permit(:group_id, :amount)
    end
end
