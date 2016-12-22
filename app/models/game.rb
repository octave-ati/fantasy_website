class Game < ApplicationRecord
  has_many :teams
  has_many :matches
  has_many :leagues
end
