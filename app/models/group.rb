class Group < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_many :constructed_buildings
  has_many :task_logs

  def balance
    (self.start_balance + total_amount_of_constructed_buildings).round 2
  end

  def constructable_buildings
    Building.all.select{
      |building| self.constructed_buildings.none? {
          |constructed_building| constructed_building.building_id == building.id}
    }
  end

  private
  def total_amount_of_constructed_buildings
    total = 0
    constructed_buildings.each do |constructed_building|
      total += constructed_building.amount
    end
    total
  end

end
