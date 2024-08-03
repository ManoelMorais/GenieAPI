# Class Diagram

``` marmaid
classDiagram
    class Conta {
        +int idConta
        +String nome
        +String cpf
        +String email
        +String senha
        +double saldo
        +Date dataCriacao
        +criarConta()
        +validarCPF()
        +validarIdade()
    }
    
    class Auth {
        +String email
        +String senha
        +login()
    }

    class Pix {
        +int idPix
        +double valor
        +String qrCode
        +gerarQRCode()
        +verificarPagamento()
    }

    class Transferencia {
        +int idTransferencia
        +int idContaOrigem
        +int idContaDestino
        +double valor
        +Date dataTransferencia
        +transferir()
    }

    class Transacao {
        +int idTransacao
        +int idConta
        +double valor
        +String tipo
        +Date dataTransacao
        +listarTransacoes()
    }

    Conta --|> Auth
    Conta "1" -- "many" Transacao : gera
    Conta "1" -- "many" Transferencia : realiza
    Conta "1" -- "many" Pix : adicionaSaldo

    Transacao "many" -- "1" Conta : pertence
    Transferencia "many" -- "1" Conta : origem
    Transferencia "many" -- "1" Conta : destino
    Pix "many" -- "1" Conta : depósito
```
