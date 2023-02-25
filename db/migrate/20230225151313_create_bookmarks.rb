class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :bookmarkable, polymorphic: true, null: false
      t.index [:user_id, :bookmarkable_id, :bookmarkable_type], name: :bookmarks_index, unique: true

      t.timestamps
    end
  end
end
