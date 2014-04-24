class Bookmark < ActiveRecord::Base
  belongs_to :folder
  validates :folder, presence: true
  validates :name, presence: true
  validates :url, presence: true, url: true

  default_scope { order('updated_at DESC') }
end
