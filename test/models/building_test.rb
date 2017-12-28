require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  test 'can build building without dependency' do
    building = buildings(:one)
    assert building.can_build?([])
  end

  test 'can not build building with dependency' do
    building = buildings(:two)
    building.required_building_id = buildings(:one).id
    assert_not building.can_build?([])
  end

  test 'can build building with dependency' do
    building = buildings(:two)
    building.required_building_id = buildings(:one).id
    assert building.can_build?([constructed_buildings(:in_running_finished)])
  end

  test 'can not build building because under construction' do
    building = buildings(:three)
    building.required_building_id = buildings(:two).id
    assert_not building.can_build?([constructed_buildings(:in_running_under_construction)])
  end
end
