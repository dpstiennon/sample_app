class RemovePictureStringFromMicroposts < ActiveRecord::Migration
  def change
    remove_column :microposts, :picture_string

  end
end
