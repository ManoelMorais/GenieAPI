function ControllerGetUserById()
  id = parse(Int, payload(:id))
  return Json.json(getUser(id))
end

function ControllerGetUsers()
  users = getUsers()
  if isempty(users)
    return Json.json("mesagem" => "No users found", status=404)
  else 
    return Json.json(users)
  end
end

function ControllerCreateUser()
  userData = jsonpayload()
  createUser(
    userData["name"],
    userData["age"],
    userData["gender"],
    userData["email"],
    userData["password"]
  )
  return Json.json("mesagem" => "User created", status=201)
end

function ControllerUpdateUser()
  id = parse(Int, params(:id))
  idx = findfirst(x -> x == id, database[!, "id"])
  if idx!== nothing
    userData = jsonpayload()
    database[idx, "name"] = userData["name"]
    database[idx, "age"] = userData["age"]
    database[idx, "gender"] = userData["gender"]
    database[idx, "email"] = userData["email"]
    database[idx, "password"] = userData["password"]
    return json("message" => "User updated successfully", status=200)
  else
    return json("message" => "User not found", status=404)
  end
end

function ControllerDeleteUser()
  idx = findfirst(x -> x == deleteUser(), database[!, "id"])
  if idx !== nothing
    deleteat!(database, idx)
    return json("message" => "User deleted", status=200)
  else
    return json("message" => "User not found", status=404)
  end
end
