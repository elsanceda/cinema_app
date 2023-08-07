class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :showing
  validates :showing_id, presence: true
  validates :user_id, presence: true
  validates :seat_number, presence: true
end
