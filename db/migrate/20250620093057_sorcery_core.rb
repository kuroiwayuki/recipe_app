class SorceryCore < ActiveRecord::Migration[7.2]
  def change
    # crypted_passwordとsaltは既にcreate_usersで作成済みなのでコメントアウトまたは削除
    # add_column :users, :crypted_password, :string
    # add_column :users, :salt, :string

    add_index :users, :email, unique: true
  end
end
