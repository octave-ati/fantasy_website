class League < ApplicationRecord
  belongs_to :game
  has_many :matches
end
