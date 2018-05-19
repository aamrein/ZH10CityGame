class Group < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :constructed_buildings
  has_many :task_logs, -> { order(:id) }
  has_many :accountings

  validates :name, :presence => true
  validates :start_balance, :presence => true

  def balance
    self.start_balance +
        total_amount_of_constructed_buildings +
        total_amount_of_tasks +
        total_accountings
  end

  def points
    self.balance.to_f +
        self.constructed_buildings.inject(0){|sum, constructed_building| sum + constructed_building.building.cost}.to_f * 0.8 +
        self.population.to_f * 100
  end

  def population
    self.constructed_buildings
        .select { |constructed_building| constructed_building.under_construction == false }
        .inject(0){|sum, constructed_building| sum + constructed_building.building.inhabitants}
  end

  def constructable_buildings
    Building.all.order(:id).select{
      |building| self.constructed_buildings.none? {
          |constructed_building| constructed_building.building_id == building.id}
    }
  end

  def constructed_buildings_finished
    self.constructed_buildings.order(:id).select{|constructed_building| !constructed_building.under_construction}
  end

  def can_build?(cost)
    self.balance >= cost && !self.building_ban
  end

  private
  def total_amount_of_constructed_buildings
    total = 0
    self.constructed_buildings.each do |constructed_building|
      total += constructed_building.amount
    end
    total
  end

  def total_amount_of_tasks
    total = 0
    self.task_logs.each do |task_log|
      task = task_log.task
      if task.value > 0
        if task_log.done
          total = task.value
        end
      else
        if !task_log.done && (!task_log.on_time || game.is_over?)
          total = task.value
        end
      end
    end
    total
  end

  def total_accountings
    self.accountings.inject(0){|sum,e| sum + e.amount}
  end
end
