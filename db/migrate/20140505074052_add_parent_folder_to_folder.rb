class AddParentFolderToFolder < ActiveRecord::Migration
  def change
    add_reference :folders, :parent_folder
  end
end
