using Dates

function ControllerGetUser()
  try
    users = getUser()
    return json(users)
  catch
    return Json.json("mesagem" => "Erro ao buscar usuarios", status=500)
  end
end

function ControllerCreateUser()
  try
    userData = jsonpayload()
    createUser(userData["cpf"], userData["nome"], userData["dataNascimento"], userData["email"], userData["password"])
    return Json.json("mesagem" => "Usuario criado", status=201)
  catch
    return Json.json("mesagem" => "Erro ao criar usuario", status=500)
  end
end