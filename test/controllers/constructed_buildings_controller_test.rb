require 'test_helper'

class ConstructedBuildingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @constructed_building = constructed_buildings(:one)
  end

  test "should get index" do
    get constructed_buildings_url
    assert_response :success
  end

  test "should get new" do
    get new_constructed_building_url
    assert_response :success
  end

  test "should create constructed_building" do
    assert_difference('ConstructedBuilding.count') do
      post constructed_buildings_url, params: { constructed_building: { building_id: @constructed_building.building_id, construction_time: @constructed_building.construction_time, group_id: @constructed_building.group_id } }
    end

    assert_redirected_to constructed_building_url(ConstructedBuilding.last)
  end

  test "should show constructed_building" do
    get constructed_building_url(@constructed_building)
    assert_response :success
  end

  test "should get edit" do
    get edit_constructed_building_url(@constructed_building)
    assert_response :success
  end

  test "should update constructed_building" do
    patch constructed_building_url(@constructed_building), params: { constructed_building: { building_id: @constructed_building.building_id, construction_time: @constructed_building.construction_time, group_id: @constructed_building.group_id } }
    assert_redirected_to constructed_building_url(@constructed_building)
  end

  test "should destroy constructed_building" do
    assert_difference('ConstructedBuilding.count', -1) do
      delete constructed_building_url(@constructed_building)
    end

    assert_redirected_to constructed_buildings_url
  end
end
