class AddPackageToRecipientAndAttachment < ActiveRecord::Migration
  def change
    change_table :recipients do |t|
      t.belongs_to :package
    end

    change_table :attachments do |t|
      t.belongs_to :package
    end
  end
end
