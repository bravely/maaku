class FolderSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :bookmarks, embed: :objects
end
