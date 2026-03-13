//
//  HttpDataSource.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 08/03/26.
//

import Foundation

struct HttpDataSource: DataSource{
    
    private let host:String
    
    init(host: String) {
        self.host = host
    }
    
    // es una funcion generica que puede recibir un tipo genero E donde E debe conformarse con el protocolo Endpoint
    
    func execute<E>(endpoint: E) async throws -> Data where E : Endpoint {
        
        // Construye componentes de URL (base + path) de forma segura
        guard var urlComponents:URLComponents = URLComponents(string: self.host + endpoint.path) else {
            throw NetworkError.invalidUrl
        }
        
        // Agrega query params si el endpoint los define
        
        if let queryParams = endpoint.queryParams {
            urlComponents.queryItems = queryParams.map{
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        // Convierte URLComponents en URL final
        guard let url:URL = urlComponents.url else {
            throw NetworkError.invalidUrl
        }
        
        // Crea el request HTTP y asigna método (GET, POST, etc.)
        var request = URLRequest(url: url)
        let httpMethod:String = ("\(endpoint.method)").uppercased()
        request.httpMethod = httpMethod
        
        
        // MARK: Ejecuta la llamada de red de forma asíncrona

        let (data,response) = try await URLSession.shared.data(for: request)
        print(data)
        print(response)
        // Verifica que la respuesta sea HTTP

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        // Acepta solo códigos 2xx como éxito

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpStatus(httpResponse.statusCode)
        }
        
        // Regresa el body crudo para que el repositorio lo decodifique

        return data
        
    }
    
    
}

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case httpStatus(Int)
    
}
