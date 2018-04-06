class ConstructedBuilding < ApplicationRecord
  belongs_to :building
  belongs_to :group
  has_many :event_logs

  def amount
    utc_now = DateTime.now.getutc
    building_amount(utc_now) + event_amount(utc_now)
  end

  def under_construction
    remaining_construction_time > 0
  end

  def remaining_construction_time
    remaining_time = (self.construction_time.getutc + building.construction_duration_sec) - DateTime.now.getutc
    remaining_time > 0 ? remaining_time : 0
  end

  private
  def building_amount(utc_now)
    game = group.game
    if self.construction_time.between?(game.start, game.start + game.duration.hours) then
      if self.under_construction then
        0 - building.cost
      else
        duration_till_build = (utc_now - (self.construction_time.getutc + building.construction_duration_sec)) / 3600
        duration_limited = limit_duration(utc_now, game,duration_till_build)
        (self.building.inhabitants * game.amount_per_inhabitants_per_hour + self.building.income_per_hour - self.building.cost_per_hour) * duration_limited - building.cost
      end
    else
      0
    end
  end

  def event_amount(utc_now)
    total = 0
    self.event_logs.each do |event_log|
      game = self.group.game
      if self.construction_time.between?(game.start, game.start + game.duration.hours) then
        event_duration_h = event_log.event.duration_min.to_f / 60
        duration_till_event = (utc_now - event_log.start.getutc) / 3600
        duration_game_limited = limit_duration(utc_now, game,duration_till_event)
        duration_limited = duration_game_limited > event_duration_h ? event_duration_h : duration_game_limited
        if duration_game_limited >= 0 then
          total += self.building.income_per_hour * duration_limited * event_log.event.impact_percent / 100
        end
      end
    end
    -total
  end

  def limit_duration(utc_now, game, duration_till_x)
    game_duration_till_start = (utc_now - game.start.getutc) / 3600
    diff = game_duration_till_start - duration_till_x
    game_duration_till_start > game.duration ?  game.duration - diff : duration_till_x
  end
end
