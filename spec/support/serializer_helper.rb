class ActiveModel::Serializer
  def to_array
    JSON.parse(to_json)
  end
end
