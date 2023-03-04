class RemoveColumnsFromArticle < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :title
    remove_column :articles, :text
  end
end
