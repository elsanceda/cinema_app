class Showing < ApplicationRecord
  belongs_to :cinema
  belongs_to :movie
  validates :cinema_id, presence: true
  validates :movie_id, presence: true
  validates :timeslot, presence: true
  validates :timeslot, uniqueness: { scope: :cinema,
                                     message: "already taken" }
end
