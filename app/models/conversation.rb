class Conversation < ApplicationRecord
  belongs_to :sender, class_name: "User", optional: true
  belongs_to :recipient, class_name: "User", optional: true
  belongs_to :vehicle,   optional: true
  belongs_to :booking,   optional: true
  has_many :messages, as: :threadable, dependent: :destroy
  validates :sender_id, uniqueness: {
    scope: [:recipient_id, :vehicle_id, :booking_id],
    message: "already has a conversation for this context"
  }

  validate :at_least_one_participant

  private

  def at_least_one_participant
    return unless sender_id.blank? && recipient_id.blank?

    errors.add(:base, "Conversation must have at least one participant")
  end
end
