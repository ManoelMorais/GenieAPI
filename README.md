# Diagrama

``` mermaid
classDiagram
    class Usuario {
        int id
        String cpf
        String nome
        Date dataNascimento
        String email
        String senha
        +boolean validarCPF()
        +boolean isAdulto()
    }

    class Conta {
        int id
        int idUsuario
        double saldo
        +void depositar(double valor)
        +void transferir(int idContaDestino, double valor)
        +double obterSaldo()
    }

    class Transacao {
        int id
        int idConta
        String tipo
        double valor
        Date data
        +boolean validarTransacao()
    }

    class ServicoAutenticacao {
        +String login(String email, String senha)
        +Usuario registrar(Usuario usuario)
    }

    class ServicoConta {
        +Conta criarConta(int idUsuario)
        +Conta obterConta(int idConta)
        +QRCode gerarDeposito(double valor)
        +boolean verificarDeposito(int idDeposito)
        +void transferir(int idContaOrigem, int idContaDestino, double valor)
    }

    class ServicoTransacao {
        +Transacao criarTransacao(int idConta, String tipo, double valor)
        +List~Transacao~ obterTransacoes(int idConta)
    }

    class ServicoPix {
        +QRCode gerarQRCode(double valor)
        +boolean verificarPagamento(QRCode)
    }

    Usuario "1" --> "1..*" Conta : possui
    Conta "1" --> "1..*" Transacao : contém
    ServicoConta --> ServicoAutenticacao : usa
    ServicoConta --> ServicoPix : usa
    ServicoConta --> ServicoTransacao : usa 
```
