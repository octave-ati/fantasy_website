class Team < ApplicationRecord
  belongs_to :game
  has_many :team_matches
  has_many :matches, through: :team_matches
end
