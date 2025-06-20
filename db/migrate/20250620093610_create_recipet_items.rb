class CreateRecipetItems < ActiveRecord::Migration[7.2]
  def change
    create_table :recipet_items do |t|
      t.references :recipet, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
