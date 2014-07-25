json.array!(@posts) do |post|
  json.extract! post, :id, :title, :content, :excerpt
  json.url post_url(post, format: :json)
end
