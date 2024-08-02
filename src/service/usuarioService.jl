using UUIDs

function createUser(cpf::Int, nome::String, dataNascimento::String, email::String, password::String)
    GerarId = UUIDs.uuid4()
    ConverterDataNascimento = Dates.format(Dates.Date(dataNascimento, "yyyy-mm-dd"), "yyyy-mm-dd")
    uuid_str = string(GerarId)

    userCreate = """INSERT INTO usuario (id, cpf, nome, dataNascimento, email, password) VALUES (?,?,?,?,?,?);"""
    
    dados = DBInterface.prepare(conn, userCreate)
    DBInterface.execute(dados, (uuid_str, cpf, nome, ConverterDataNascimento, email, password))
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