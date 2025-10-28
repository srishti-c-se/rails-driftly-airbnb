class Bookmark < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :vehicle
  belongs_to :user
  # VALIDATIONS
  validates :vehicle_id, uniqueness: { scope: :user_id }
end
