class AddOnDeleteCascadeToUserForeignKeys < ActiveRecord::Migration[7.2]
  def change
    # Articles
    remove_foreign_key :articles, :users
    add_foreign_key :articles, :users, on_delete: :cascade

    # Collaborations
    remove_foreign_key :collaborations, :users
    add_foreign_key :collaborations, :users, on_delete: :cascade

    # Comments
    remove_foreign_key :comments, :users
    add_foreign_key :comments, :users, on_delete: :cascade

    # Notifications
    remove_foreign_key :notifications, :users
    add_foreign_key :notifications, :users, on_delete: :cascade

    # Payments (payer_id, payee_id)
    # remove_foreign_key :payments, :users, column: :payer_id
    # add_foreign_key :payments, :users, column: :payer_id, on_delete: :cascade

    # remove_foreign_key :payments, :users, column: :payee_id
    # add_foreign_key :payments, :users, column: :payee_id, on_delete: :cascade

    # Reactions
    remove_foreign_key :reactions, :users
    add_foreign_key :reactions, :users, on_delete: :cascade
  end
end

