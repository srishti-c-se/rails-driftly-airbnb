class Message < ApplicationRecord
  belongs_to :threadable, polymorphic: true
  belongs_to :user, optional: true

  validates :body, presence: true
  after_create_commit :broadcast_message

  private

  def broadcast_message
    broadcast_append_to(
      "thread_#{threadable_type}_#{threadable_id}_messages",
      target: "messages",
      partial: "messages/message",
      locals: { message: self, user: user }
    )
  end
end
