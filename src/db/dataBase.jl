using MySQL, DBInterface

host = "localhost"
user = "root"
passwd = "Sda1945b"

conn = DBInterface.connect(MySQL.Connection, host, user, passwd)
DBInterface.execute(conn, "CREATE DATABASE IF NOT EXISTS people")
DBInterface.execute(conn, "USE people")
DBInterface.execute(conn, """CREATE TABLE IF NOT EXISTS usuario (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        name VARCHAR(100) NOT NULL,
                        age INT NOT NULL,
                        gender VARCHAR(1) NOT NULL,
                        email VARCHAR(100) NOT NULL,
                        password VARCHAR(50) NOT NULL
                        );""")