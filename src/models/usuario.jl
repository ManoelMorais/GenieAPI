using UUIDs
using Dates

struct Usuario
  id::UUID
  cpf::String
  name::String
  dataNascimento::String
  email::String
  password::String
end

function validarCPF(cpf::String)::Bool
  return length(cpf) == 11 && all(isdigit, cpf)
end

function validarDataNascimento(dataNascimento::String)::Bool
  hoje = Dates.now()
  dataUsuario = Date(dataNascimento, "yyyy-mm-dd")
  anoUsuario = year(dataUsuario)
  return year(hoje) - anoUsuario >= 18
end

function usuarioExiste(conn, cpf::String, email::String)::Bool
  query = "SELECT COUNT(*) FROM usuario WHERE cpf = ? OR email = ?"
  stmt = DBInterface.prepare(conn, query)
  result = DBInterface.execute(stmt, (cpf, email))
  count = first(result)[1]
  return count > 0
end