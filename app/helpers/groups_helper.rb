module GroupsHelper

  def buildings_categories(buildings)
    buildings.collect {|building| building.category}.uniq
  end

  def constructed_buildings_categories(constructed_buildings)
    constructed_buildings.collect {|constructed_building| constructed_building.building.category}.uniq
  end

end
