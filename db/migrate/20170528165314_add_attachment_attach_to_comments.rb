class AddAttachmentAttachToComments < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.attachment :attach
    end
  end

  def self.down
    remove_attachment :comments, :attach
  end
end
