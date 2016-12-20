class AddTimestampToTeamMatches < ActiveRecord::Migration[5.0]
  def change
    add_column :team_matches, :datetime, :timestamp, unique: true
  end
end
