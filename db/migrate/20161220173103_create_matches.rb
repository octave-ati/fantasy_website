class CreateMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :matches do |t|
      t.belongs_to :game, index: true
      t.timestamp :datetime, null: false
      t.timestamps
      
    end
  end
end
