class Movie < ApplicationRecord
    validates :title, presence: true
    validates :synopsis, presence: true
    has_many :showings, dependent: :destroy
    has_many :cinemas, through: :showings
    default_scope -> { order(created_at: :desc) }

    # Returns a movie's showings.
    def movie_showings
        Showing.where(movie_id: id)
    end
end
