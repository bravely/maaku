class User < ActiveRecord::Base
  has_many :folders
  validates :username, presence: true
end
