class ChangeEmbeddingDimensionsInArticles < ActiveRecord::Migration[7.2]
  def change
    change_column :articles, :embeddings, :vector, limit: 384
  end
end
