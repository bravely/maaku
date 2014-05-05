class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :name, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
