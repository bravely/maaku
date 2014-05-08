class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false

      t.timestamps
    end

    change_table :folders do |t|
      t.belongs_to :user
    end
  end
end
