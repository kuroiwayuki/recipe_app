class CreateRecipets < ActiveRecord::Migration[7.2]
  def change
    create_table :recipets do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :purchased_at

      t.timestamps
    end
  end
end
