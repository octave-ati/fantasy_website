class CreateLeagues < ActiveRecord::Migration[5.0]
  def change
    create_table :leagues do |t|
      t.string :name, unique: true, null: false, index:true
      t.string :logo_url
      t.belongs_to :game
      t.timestamps
    
    end
    
    add_reference :matches, :league, index: true, foreign_key: true 
  end
end
