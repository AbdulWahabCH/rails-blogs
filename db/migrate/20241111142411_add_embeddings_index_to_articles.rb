class AddEmbeddingsIndexToArticles < ActiveRecord::Migration[7.2]
  def change
    # Add the ivfflat index to the embeddings column
    execute <<-SQL
      CREATE INDEX articles_embeddings_index ON articles USING ivfflat(embeddings vector_l2_ops);
    SQL
  end
end
