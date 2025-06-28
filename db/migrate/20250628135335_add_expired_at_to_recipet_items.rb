class AddExpiredAtToRecipetItems < ActiveRecord::Migration[7.2]
  def change
    add_column :recipet_items, :expired_at, :date
  end
end
