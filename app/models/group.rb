class Group < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :constructed_buildings
  has_many :task_logs

  validates :name, :presence => true
  validates :start_balance, :presence => true

  def balance
    (self.start_balance + total_amount_of_constructed_buildings + total_amount_of_tasks).round 2
  end

  def points
    self.balance +
        self.constructed_buildings.inject(0){|sum, constructed_building| sum + constructed_building.building.cost}
  end

  def constructable_buildings
    Building.all.select{
      |building| self.constructed_buildings.none? {
          |constructed_building| constructed_building.building_id == building.id}
    }
  end

  def constructed_buildings_finished
    self.constructed_buildings.select{|constructed_building| !constructed_building.under_construction}
  end

  def can_build?(cost)
    self.balance >= cost
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
      if task_log.done
        if task.settlement_immediately || !task.settlement_immediately && game.is_over?
          total += task.value
        end
      else
        if game.is_over? && !task.optional
          total += task.value
        end
      end
    end
    total
  end
end
