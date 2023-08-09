class Cinema < ApplicationRecord
    validates :name, presence: true
    validates :location, presence: true
    validates :seats, presence: true, :inclusion => 1..10
    has_many :showings, dependent: :destroy
    has_many :bookings, through: :showings
    default_scope -> { order(created_at: :desc) }
end
