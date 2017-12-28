class Category < ApplicationRecord
  has_many :buildings, -> { order(id: :asc) }
end
