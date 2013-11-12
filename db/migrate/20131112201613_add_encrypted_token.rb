class AddEncryptedToken < ActiveRecord::Migration
  def change
    change_table :packages do |t|
      t.string :encrypted_token
    end
  end
end
