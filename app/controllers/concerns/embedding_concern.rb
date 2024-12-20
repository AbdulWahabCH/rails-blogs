# app/controllers/concerns/embedding_concern.rb
require "json"
require "open3"

module EmbeddingConcern
  extend ActiveSupport::Concern

  def generate_embeddings(text)
    python_interpreter = "/home/dev/Desktop/python_proj/legal-agent-embeddings/env/bin/python"
    script_path = "/home/dev/Desktop/python_proj/legal-agent-embeddings/index.py"
    command = "#{python_interpreter} #{script_path} #{Shellwords.escape(text)}"  # Safely escape text

    stdout, stderr, status = Open3.capture3(command)

    if status.success?
      JSON.parse(stdout)
    else
      Rails.logger.error("Embedding generation failed: #{stderr}")  # Log errors
      nil
    end
  end
end
