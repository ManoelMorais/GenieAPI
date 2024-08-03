using MySQL, DBInterface

host = "localhost"
user = "root"
passwd = "Sda1945b"

conn = DBInterface.connect(MySQL.Connection, host, user, passwd)
DBInterface.execute(conn, "CREATE DATABASE IF NOT EXISTS banco")
DBInterface.execute(conn, "USE banco")
DBInterface.execute(conn, """CREATE TABLE IF NOT EXISTS usuario (
                        id CHAR(36) PRIMARY KEY,
                        cpf CHAR(11) UNIQUE NOT NULL,
                        nome VARCHAR(100) NOT NULL,
                        dataNascimento DATE NOT NULL,
                        email VARCHAR(100) UNIQUE NOT NULL,
                        password VARCHAR(50) NOT NULL
                        );""")

DBInterface.execute(conn, """CREATE TABLE IF NOT EXISTS conta (
                        id CHAR(36) PRIMARY KEY,
                        idUsuario CHAR(36) NOT NULL,
                        saldo FLOAT NOT NULL,
                        FOREIGN KEY (idUsuario) REFERENCES usuario(id)
                        );""")
                        
DBInterface.execute(conn, """CREATE TABLE IF NOT EXISTS transacao (
                        id CHAR(36) PRIMARY KEY,
                        idConta CHAR(36) NOT NULL,
                        valor FLOAT NOT NULL,
                        data TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        tipo ENUM('deposito', 'saque') NOT NULL,
                        FOREIGN KEY (idConta) REFERENCES conta(id)
                        );""")