
import Foundation
import UIKit

class BeerAPI {
    
    static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default //Modo de sessão mais comum
        //URLSessionConfiguration.ephemeral //Modo privado de sessão
        //URLSessionConfiguration.background(withIdentifier: "bg") //Modo sessão em bg do app
        
        config.allowsCellularAccess = true //Usar a rede celular
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]//Definir cabeçalho para todos requests
        config.timeoutIntervalForRequest = 30.0 //Determinar um tempo para timeout
        config.httpMaximumConnectionsPerHost = 4 //Limitar a uma unica conexão ao host
        
        return config
    }()
    
    static let session = URLSession(configuration: configuration)
    
    static func getBeers(beerPage: Int, onComplete: @escaping ([Beer]?) -> Void){
        let urlString = "https://api.punkapi.com/v2/beers?page=\(beerPage)"
        
        guard let url = URL(string: urlString) else {
            onComplete(nil)
            return
        }
        
        //GET
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print(error!.localizedDescription)
                onComplete(nil)
            } else {
                guard let response = response as? HTTPURLResponse else {
                    onComplete(nil)
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else {
                        onComplete(nil)
                        return
                    }
                    
                    //Sucesso na leitura do request
                    let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [[String: Any]] //Array de dicionarios = json
                    
                    var beers: [Beer] = [] //Inicializa um array vazio de cervejas
                    
                    for item in json {
                        let id = item["id"] as! Int
                        let name = item["name"] as! String
                        let url = item["image_url"] as! String
                        let teor = item["abv"] as! Float
                        let tag = item["tagline"] as! String
                        
                        var ibu: Float = 0.0
                        if !(item["ibu"] is NSNull) {
                            ibu = item["ibu"] as! Float
                        }
                        
                        
                        let description = item["description"] as! String
                        
                        let beer = Beer(id: id, name: name, url: url, teor: teor, tag: tag, ibu: ibu, description: description)
                        beers.append(beer) //Adiciona item a um array
                    }
                    onComplete(beers)
                    
                } else {
                    onComplete(nil)
                    return
                }
                
            }
            
            }.resume()
    }
    
}
