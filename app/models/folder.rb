class Folder < ActiveRecord::Base
  has_many :bookmarks
  validates :name, presence: true

  default_scope { order('name ASC') }
end
