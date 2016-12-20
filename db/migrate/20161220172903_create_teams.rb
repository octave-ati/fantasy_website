class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :logo_url
      t.belongs_to :game, index: true
      t.timestamps
    end
  end
end
