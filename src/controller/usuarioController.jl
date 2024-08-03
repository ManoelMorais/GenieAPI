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

    if !validarCPF(string(userData["cpf"]))
      return Json.json("mesagem" => "Erro na validação do CPF", status=400)
    end
    
    if !validarDataNascimento(userData["dataNascimento"]) 
      return Json.json("mesagem" => "Usuario menor de idade", status=400)
    end

    dataNascimento = Date(userData["dataNascimento"], "yyyy-mm-dd")
    dataNascimentoStr = Dates.format(dataNascimento, "yyyy-mm-dd")

    createUser(string(userData["cpf"]), userData["nome"], dataNascimentoStr, userData["email"], userData["password"])
    return Json.json("mesagem" => "Usuario criado", status=201)
  catch e
    return Json.json("mesagem" => "erro $e", status=500)
  end
end