class Movie < ApplicationRecord
    validates :title, presence: true
    validates :synopsis, presence: true
    has_many :showings, dependent: :destroy
    has_many :cinemas, through: :showings
end
