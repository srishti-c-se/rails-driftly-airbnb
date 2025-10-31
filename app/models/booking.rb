class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle
  has_many   :messages, as: :threadable, dependent: :destroy

  enum status: {
    pending:   0,
    accepted:  1,
    rejected:  2,
    cancelled: 3,
    completed: 4
  }

  enum payment_status: {
    unpaid:   0,
    paid:     1,
    refunded: 2
  }

  validates :start_date, :end_date, presence: true
  validate  :end_after_start

  def end_after_start
    return if start_date.blank? || end_date.blank?
    errors.add(:end_date, "must be after start date")  if end_date <= start_date
  end
end
