class AddEncryptedPasswordToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :encrypted_password, :string, null: false, default: ""
  end
end
