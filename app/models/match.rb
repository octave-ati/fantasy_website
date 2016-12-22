class Match < ApplicationRecord
  belongs_to :game
  has_many :team_matches, dependent: :destroy
  has_many :teams, through: :team_matches
  belongs_to :league
end
