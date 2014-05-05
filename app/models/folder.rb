class Folder < ActiveRecord::Base
  has_many :bookmarks
  has_many :subfolders, class_name: 'Folder', foreign_key: 'parent_folder_id'
  belongs_to :parent_folder, class_name: 'Folder'

  validates :name, presence: true

  default_scope { order('name ASC') }
end
