class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # VALIDATIONS
  validates :first_name, :last_name, :email, :phone, presence: true
  validates :email, uniqueness: true
  validates :phone, numericality: { only_integer: true }

  # GEOCODING
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # ASSOCIATIONS
  has_many :vehicles, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :messages, dependent: :nullify
  has_many :notifications, dependent: :destroy

  # Conversations as sender or recipient
  has_many :conversations_as_sender,
           class_name: "Conversation",
           foreign_key: :sender_id,
           dependent: :nullify

  has_many :conversations_as_recipient,
           class_name: "Conversation",
           foreign_key: :recipient_id,
           dependent: :nullify
end
