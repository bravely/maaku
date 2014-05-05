class ShallowFolderSerializer < ActiveModel::Serializer
  attributes :id, :name

  self.root = 'folder'
end
