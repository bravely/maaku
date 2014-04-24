class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :name, null: false

      t.timestamps
    end

    change_table :bookmarks do |t|
      t.belongs_to :folder
    end
  end
end
