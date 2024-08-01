using UUIDs

function createUser(cpf::Int, nome::String, dataNascimento::String, email::String, password::String)
  try
    if !validarCPF(cpf)
      return Json.json("mesagem" => "CPF invalido", status=400)
    end
    if !validarDataNascimento(dataNascimento)
      return Json.json("mesagem" => "Cliente não possui idade suficiente", status=400)
    end
  
    GerarId = UUIDs.uuid4()
    ConverterDataNascimento = Dates.format(Dates.Date(dataNascimento, "yyyy-mm-dd"), "yyyy-mm-dd")

    println("****************************************************************************************************************************")
    println("Criando usuário com CPF: $cpf, Nome: $nome, Data de Nascimento: $dataNascimento, Email: $email")
    println("****************************************************************************************************************************")
    userCreate = """INSERT INTO usuario (id, cpf, nome, dataNascimento, email, password) VALUES (?,?,?,?,?,?);"""
    
    dados = DBInterface.prepare(conn, userCreate)
    
    uuid_str = string(GerarId)
    DBInterface.execute(dados, (uuid_str, cpf, nome, ConverterDataNascimento, email, password))
    
    println("****************************************************************************************************************************")
    println("Transação confirmada")
    return JSON.json("mensagem" => "Usuario criado", "status" => 201)
  catch e
    println("Erro ao criar usuário: $e")
    return Json.json("mesagem" => "Erro ao criar usuario", status=500)
  end
end

function getUser()
  result = DBInterface.prepare(conn, "SELECT * FROM usuario")
  dados = DBInterface.execute(result)
  users = []
  for row in dados
    user = Dict(
      "id" => row.id,
      "cpf" => row.cpf,
      "nome" => row.nome,
      "dataNascimento" => row.dataNascimento,
      "email" => row.email,
      "password" => row.password
    )
    push!(users, user)
  end
  return users
end