using UUIDs

function createUser(cpf::String, nome::String, dataNascimento::String, email::String, password::String)
  if usuarioExiste(conn, cpf, email)
    throw(ErrorException("Usuário já existe com este CPF ou email"))
  end

  GerarId = UUIDs.uuid4()
  uuid_str = string(GerarId)

  userCreate = """INSERT INTO usuario (id, cpf, nome, dataNascimento, email, password) VALUES (?,?,?,?,?,?);"""

  dados = DBInterface.prepare(conn, userCreate)
  DBInterface.execute(dados, (uuid_str, cpf, nome, dataNascimento, email, password))
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