using UUIDs
using Dates

struct Usuario
  id::UUID
  cpf::Int
  name::String
  dataNascimento::Date
  email::String
  password::String
end

function validarCPF(cpf::Int)
  if ndigits(cpf) != 11
    return false
  end
  return true
end

function validarDataNascimento(dataNascimento::String)
  hoje = Dates.now()
  dataUsuario = Date(dataNascimento, "yyyy-mm-dd")
  anoUsuario = year(dataUsuario)
  if year(hoje) - anoUsuario < 18
    return false
  end
  return true
end