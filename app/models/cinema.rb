class Cinema < ApplicationRecord
    validates :name, presence: true
    validates :location, presence: true
    validates :seats, :inclusion => 1..10
    has_many :showings, dependent: :destroy
    has_many :movies, through: :showings
end
