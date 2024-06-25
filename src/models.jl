function getId()
  id = parse(Int, params(:id))
  return id
end

function createUser(name::String, age::Int, gender::String, email::String, password::String)
  userCreate = """INSERT INTO usuario (name, age, gender, email, password) VALUES (?,?,?,?,?);"""
  dados = DBInterface.prepare(conn, userCreate)
  DBInterface.execute(dados,(name, age, gender, email, password))
end

function getUser()
  result = DBInterface.prepare(conn, "SELECT * FROM usuario WHERE id = ?")
  dados = DBInterface.execute(result,(getId(),))
  if isempty(dados)
    return Json.error("User not found")
  else
    return Dict(
      "id" => dados.id[1],
      "name" => dados.name[1],
      "age" => dados.age[1],
      "gender" => dados.gender[1],
      "email" => dados.email[1],
      "password" => dados.password[1]
    )
  end
end

function getUsers(result)
  ret = []
  for row in result
    push!(ret, Dict(
      "id" => row[1],
      "name" => row[2],
      "age" => row[3],
      "gender" => row[4],
      "email" => row[5],
      "password" => row[6],
    ))
  end
  return ret
end

function updateUser(name::String, age::Int, gender::String, email::String, password::String)
  updateUser = """UPDATE usuario SET name =?, age =?, gender =?, email =?, password =?"""
  dados = DBInterface.prepare(conn,updateUser)
  DBInterface.execute(dados, (name, age, gender, email, password, ))
end