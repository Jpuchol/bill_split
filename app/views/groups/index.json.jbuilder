json.array!(@groups) do |group|
  json.extract! group, :name, :owner, :comment
  json.url group_url(group, format: :json)
end