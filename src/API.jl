#module API

using DataFrames, Genie, Genie.Router, Genie.Renderer, Genie.Renderer.Json, Genie.Requests

database = DataFrame(
  "id" => Vector{Int}(),
  "name" => Vector{String}(),
  "age" => Vector{Int}(),
  "gender" => Vector{String}(),
  "email" => Vector{String}(),
  "password" => Vector{String}(),
)

function newUser(name::String, age::Int, gender::String, email::String, password::String)
  id = nrow(database) + 1
  push!(database, (
    id, name, age, gender, email, password
  ))
end

function getUser(id::Int)
  return filter(x -> x.id == id, database)
end

function getUsers()
  db = database
  ret = []
  for i in 1:nrow(db)
    push!(ret, Dict(
      "id" => db.id[i],
      "name" => db.name[i],
      "age" => db.age[i],
      "gender" => db.gender[i],
      "email" => db.email[i],
      "password" => db.password[i],
    ))
  end
  return ret
end

function ControllerGetUsers()
  users = getUsers()
  return Json.json(users)
end

function ControllerCreateUser()
  userData = jsonpayload()

  newUser(
    userData["name"],
    userData["age"],
    userData["gender"],
    userData["email"],
    userData["password"]
  )
  return Json.json("User created",status=201)
end

route(ControllerGetUsers, "/page/users", method="GET")
route(ControllerGetUsers, "/page/users/:id", method="GET")
route(ControllerCreateUser, "/page/user/createuser", method="POST")

#end # module API
