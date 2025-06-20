class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :unit
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
