class EventLog < ApplicationRecord
  belongs_to :event
  belongs_to :constructed_building
end
