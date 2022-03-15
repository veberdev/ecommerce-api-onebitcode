json.categories do
  json.array! @categories, :id, :name
end

# { "categories" : [  { "id": "x", "name": "qwerty"},
#                     { "id": "x", "name": "qwerty"},
#                     { "id": "x", "name": "qwerty"},
#                     { "id": "x", "name": "qwerty"}
#                 ]
# }