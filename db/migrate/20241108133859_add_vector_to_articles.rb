class AddVectorToArticles < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :embeddings, :vector, limit: 1536
  end
end
