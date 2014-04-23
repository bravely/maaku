class Bookmark < ActiveRecord::Base
  validates :name, presence: true
  validates :url, presence: true, url: true

  default_scope { order('updated_at DESC') }
end
