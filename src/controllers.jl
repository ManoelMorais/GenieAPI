function ControllerGetUserById()
  id = getId()
  if isempty(getUser(id))
    return Json.json("mesagem" => "User not found", status=404)
  end
  return Json.json(getUser(id))
end

function ControllerGetUsers()
  result = DBInterface.execute(conn,"SELECT * FROM usuario")
  dadosUser = getUsers(result)
  if isempty(dadosUser)
    return Json.json("mesagem" => "No users found", status=404)
  end
  return Json.json(dadosUser)
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
  id = getId()
  if id !== nothing
    userData = jsonpayload()
    updateUser(
      userData["name"],
      userData["age"],
      userData["gender"],
      userData["email"],
      userData["password"],
    )
    return json("message" => "User updated successfully", status=200)
  else
    return json("message" => "User not found", status=404)
  end
end

function ControllerDeleteUser()
  delete = DBInterface.prepare(conn, "DELETE FROM usuario WHERE id =?")
  DBInterface.execute(delete, (getId(),))
  return Json.json("mensagem" => "User delete successfully", status = 200)
end
