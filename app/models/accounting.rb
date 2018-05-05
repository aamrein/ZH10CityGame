class Accounting < ApplicationRecord

  validates :group_id, :presence => true
  validates :amount, :presence => true

end
