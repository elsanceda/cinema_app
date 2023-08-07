class Showing < ApplicationRecord
  belongs_to :cinema
  belongs_to :movie
  belongs_to :timeslot
end
