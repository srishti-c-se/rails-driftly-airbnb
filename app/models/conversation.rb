class Conversation < ApplicationRecord
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
