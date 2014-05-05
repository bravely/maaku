class FolderSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :bookmarks, embed: :objects
  has_many :subfolders, embed: :ids
end
