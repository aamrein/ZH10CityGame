class Building < ApplicationRecord
  belongs_to :category
  belongs_to :required_building, class_name: 'Building'

  mount_uploader :image, BuildingImageUploader

  def can_build?(constructed_buildings)
    self.required_building_id.nil? || constructed_buildings.any? { |cb|
      (cb.building.id == self.required_building_id) && !cb.under_construction
    }
  end

  def construction_duration_min
    self.construction_duration_sec / 60
  end
end
