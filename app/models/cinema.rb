class Cinema < ApplicationRecord
    validates :name, presence: true
    validates :location, presence: true
    validates :seats, presence: true, :inclusion => 1..10
    has_many :showings, dependent: :destroy
    has_many :movies, through: :showings
    default_scope -> { order(created_at: :desc) }

    # Returns a cinema's showings.
    def cinema_showings
        Showing.where(cinema_id: id)
    end
end
