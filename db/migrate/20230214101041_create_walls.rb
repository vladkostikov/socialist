class CreateWalls < ActiveRecord::Migration[7.0]
  def change
    create_table :walls do |t|
      t.references :wallable, polymorphic: true
      t.timestamps
    end
    add_reference :articles, :wall, null: false, foreign_key: true
  end
end
