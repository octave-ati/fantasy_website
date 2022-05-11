class AddNameIndexToTeamsAndDateTimeIndexToMatches < ActiveRecord::Migration[5.0]
  def change
    add_index :matches, :datetime
    add_index :teams, :name
  end
end
