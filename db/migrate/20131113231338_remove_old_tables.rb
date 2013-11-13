class RemoveOldTables < ActiveRecord::Migration
  def change
    drop_table :senders
    drop_table :recipients
    change_table :attachments do |t|
      remove_column :attachments, :file_name
      remove_column :attachments, :file_type
      remove_column :attachments, :sender_id
    end
  end
end
