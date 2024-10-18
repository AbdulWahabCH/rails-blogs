class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :actor, polymorphic: true, null: false
      t.references :notifiable, polymorphic: true, null: false
      t.integer :action
      t.integer :status

      t.timestamps
    end
  end
end
