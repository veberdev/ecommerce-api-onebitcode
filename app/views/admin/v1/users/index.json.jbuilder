json.users do
  json.array! @users, :id, :name, :email, :profile
end
# { "users" : [  { "id": "x", "name": "qwerty", email: "asd@asd", profile: "admin"},
#                     { "id": "x", "name": "qwerty", email: "asd@asd", profile: "client"},
#                     { "id": "x", "name": "qwerty", email: "asd@asd", profile: "admin"},
#                     { "id": "x", "name": "qwerty", email: "asd@asd", profile: "client"}
#                 ]
# }