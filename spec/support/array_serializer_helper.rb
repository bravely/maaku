class ActiveModel::ArraySerializer
  def to_array
    JSON.parse(to_json)
  end
end
