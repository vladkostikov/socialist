class EditComments < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.references :commentable, polymorphic: true
    end

    add_reference :comments, :user, null: false, foreign_key: true
    add_column :comments, :parent_id, :bigint
    remove_column :comments, :article_id, :bigint
    remove_column :comments, :author, :bigint
  end
end
