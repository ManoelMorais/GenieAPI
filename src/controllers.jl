function ControllerGetUserById()
  try
    id = getUser()
    return Json.json(id, status=200)
  catch
    return Json.json("mesagem" => "User not found", status=404)
  end
end

function ControllerGetUsers()
  try
    result = DBInterface.execute(conn, "SELECT * FROM usuario")
    dadosUser = getUsers(result)
    return Json.json(dadosUser, status=200)
  catch
    return Json.json("mesagem" => "Error in the database", status=500)
  end
end

function ControllerCreateUser()
  try
    userData = jsonpayload()
    createUser(
      userData["name"],
      userData["age"],
      userData["gender"],
      userData["email"],
      userData["password"]
    )
    return Json.json("mesagem" => "User created", status=201)
  catch
    return Json.json("mesagem" => "Error in the create user", status=204)
  end
end

function ControllerUpdateUser()
  try
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
    end
  catch
    return json("message" => "User not found", status=404)
  end
end

function ControllerDeleteUser()
  try
    delete = DBInterface.prepare(conn, "DELETE FROM usuario WHERE id =?")
    DBInterface.execute(delete, (getId(),))
    return Json.json("mensagem" => "User delete successfully", status=200)
  catch
    return Json.json("mensagem" => "User not found", status=404)
  end
end
