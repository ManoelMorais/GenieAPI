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
    println("****************************************************************************************************************************")
    println("Iniciando ControllerCreateUser")
    userData = jsonpayload()
    println("****************************************************************************************************************************")
    println("Dados recebidos: $userData")
    println("****************************************************************************************************************************")
    createUser(userData["cpf"], userData["nome"], userData["dataNascimento"], userData["email"], userData["password"])
    return Json.json("mesagem" => "Usuario criado", status=201)
  catch e
    println("Erro ao criar usuário: $e")
    return Json.json("mesagem" => "Erro ao criar usuario", status=500)
  end
end