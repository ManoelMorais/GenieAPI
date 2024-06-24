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
  user = filter(x -> x.id == id, database)
  if isempty(user)
    return nothing
  else
    return Dict(
      "id" => user.id[1],
      "name" => user.name[1],
      "age" => user.age[1],
      "gender" => user.gender[1],
      "email" => user.email[1],
      "password" => user.password[1]
    )
  end
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

function ControllerGetUserById()
  id = parse(Int, payload(:id))
  return Json.json(getUser(id))
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
route(ControllerGetUserById, "/page/users/:id", method="GET")
route(ControllerCreateUser, "/page/user/createuser", method="POST")

#end # module API
