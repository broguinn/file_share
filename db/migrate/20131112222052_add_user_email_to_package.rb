class AddUserEmailToPackage < ActiveRecord::Migration
  def change
    change_table :packages do |t|
      t.string :user_email
      t.string :user_name
      t.string :recipient_email
    end
  end
end
