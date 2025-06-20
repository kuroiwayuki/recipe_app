class CreateExpirationItems < ActiveRecord::Migration[7.2]
  def change
    create_table :expiration_items do |t|
      t.references :recipet_item, null: false, foreign_key: true
      t.integer :quantity
      t.date :expires_at
      t.string :status

      t.timestamps
    end
  end
end
