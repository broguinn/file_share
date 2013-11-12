class AddSenderToPackage < ActiveRecord::Migration
  def change
    change_table :packages do |t|
      t.belongs_to :sender
    end
  end
end
