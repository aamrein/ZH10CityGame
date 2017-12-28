require 'test_helper'

class ConstructedBuildingTest < ActiveSupport::TestCase
  test 'under construction false' do
    assert !constructed_buildings(:in_running_finished).under_construction
  end

  test 'under construction' do
    assert constructed_buildings(:in_running_under_construction).under_construction
  end

  test 'building amount' do
    constructed_building = constructed_buildings(:in_running_finished)
    building = constructed_building.building
    calculated_amount = constructed_building.send(:building_amount, constructed_building.construction_time + 2.hours)
    expected_amount = (building.inhabitants * 100 + building.income_per_hour - building.cost_per_hour) * 1.75 - building.cost
    assert_equal expected_amount, calculated_amount
  end

  test 'building amount under construction' do
    constructed_building = constructed_buildings(:in_running_under_construction)
    calculated_amount = constructed_building.send(:building_amount, constructed_building.construction_time + 1.hours)
    expected_amount = 0 - constructed_building.building.cost
    assert_equal expected_amount, calculated_amount
  end

  test 'building amount constructed before the game start' do
    constructed_building = constructed_buildings(:before_running)
    calculated_amount = constructed_building.send(:building_amount, DateTime.now().getutc)
    expected_amount = 0
    assert_equal expected_amount, calculated_amount
  end

  test 'event amount' do
    constructed_building = constructed_buildings(:in_running_finished)
    calculated_amount = constructed_building.send(:event_amount, constructed_building.construction_time + 90.minutes)
    expected_amount = -(constructed_building.building.income_per_hour * 0.1 / 60)
    assert_in_delta expected_amount, calculated_amount, 0.0001
  end

  test 'event amount two events' do
    constructed_building = constructed_buildings(:in_running_finished)
    calculated_amount = constructed_building.send(:event_amount, constructed_building.construction_time + 2.hours)
    expected_amount = -(constructed_building.building.income_per_hour * 0.1 / 60) * 2
    assert_in_delta expected_amount, calculated_amount, 0.0001
  end

  test 'event amount half event' do
    constructed_building = constructed_buildings(:in_running_finished)
    calculated_amount = constructed_building.send(:event_amount, constructed_building.construction_time + 60.5.minutes)
    expected_amount = -(constructed_building.building.income_per_hour * 0.1 / 60) * 0.5
    assert_in_delta expected_amount, calculated_amount, 0.0001
  end
end
