class Showing < ApplicationRecord
  belongs_to :cinema
  belongs_to :movie
  has_many :bookings, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :cinema_id, presence: true
  validates :movie_id, presence: true
  validates :timeslot, presence: true
  validates :timeslot, uniqueness: { scope: :cinema,
                                     message: "already taken" }
  
  # Returns list of seats that are already taken
  def booked_seats
    Booking.where(showing_id: id).pluck(:seat_number)
  end

  # Returns list of seats that are available for booking 
  def available_seats
    seats = self.cinema.seats
    booked = booked_seats
    (1..seats).reject { |seat| booked.include?(seat) }
  end
end
