class CreateCollaborations < ActiveRecord::Migration[7.2]
  def change
    create_table :collaborations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end
