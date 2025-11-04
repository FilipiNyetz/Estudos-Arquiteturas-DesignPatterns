import UIKit


// que retorna uma String — representando algum tipo de requisição.
//Protocolo que implementa a função request, que retorna uma string. E esse protocolo(contrato) define que todas as estruturas que o implementarem devem ter essa função
protocol ReturnRequest{
    func request() -> String
}

//Classe de conexão com a rede que possui apenas um método em conformidade ao protocólo
class Network: ReturnRequest{
    //implementação da função do protocolo
    func request() -> String {
        return "Network Request"
    }
}

//Classe que representa o DB e possui um método único para realizar um fetch dos dados
// Ela não segue o protocolo `ReturnRequest` de início.
// Em vez disso, ela possui seu próprio método `fetch()`.
class Database{
     func fetch() -> String {
         return "Database Request"
    }
}

// MARK: - Extensão (Adapter Pattern) ISSO É IMPORTANTE
//Essa extensão "adapta" a classe Database para conformar com o protocolo ReturnRequest.
// Assim, podemos tratar Database e Network de forma uniforme, via o mesmo tipo (ReturnRequest).
extension Database: ReturnRequest{
    //implementação da função exigida pelo protocolo
    //Adapta o método request do protocolo com o método fetch da classe
    func request() -> String {
        return fetch()
    }
}


