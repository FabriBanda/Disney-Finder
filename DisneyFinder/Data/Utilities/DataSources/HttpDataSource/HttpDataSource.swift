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
    
    // Generic function that receives a type E constrained to the Endpoint protocol.
    
    func execute<E>(endpoint: E) async throws -> Data? where E : Endpoint {
        
        do{
            // Safely builds URL components using the base host and endpoint path.
            guard var urlComponents:URLComponents = URLComponents(string: self.host + endpoint.path) else {
                throw RepositoryError.invalidUrl
            }
            
            // Adds query params when the endpoint provides them.
            
            if let queryParams = endpoint.queryParams {
                urlComponents.queryItems = queryParams.map{
                    URLQueryItem(name: $0.key, value: $0.value)
                }
            }
            
            // Converts URLComponents into the final URL.
            guard let url:URL = urlComponents.url else {
                throw RepositoryError.invalidUrl
            }
            
            // Creates the HTTP request and assigns the method (GET, POST, etc.).
            var request = URLRequest(url: url)
            let httpMethod:String = ("\(endpoint.method)").uppercased()
            request.httpMethod = httpMethod
            
            
            // MARK: Executes the network request asynchronously

            let (data,response) = try await URLSession.shared.data(for: request)
            
            // Ensures the response is an HTTP response.

            guard let httpResponse = response as? HTTPURLResponse else {
                throw RepositoryError.invalidResponse
            }
            
            // Accepts only 2xx status codes as success.

            guard (200...299).contains(httpResponse.statusCode) else {
                throw RepositoryError.httpStatus(httpResponse.statusCode)
           }
            
            // Returns the raw body so the repository can decode it.

            return data
            
        }catch let urlError as URLError{
            var error:Error
            switch urlError.code{
            case .notConnectedToInternet:
               error = RepositoryError.noInternetConnection
            case .networkConnectionLost:
                error = RepositoryError.networkConnectionLost
            case .cannotConnectToHost:
                error = RepositoryError.cannotConnectToHost
            case .cannotFindHost:
                error = RepositoryError.cannotFindHost
            default:
                throw RepositoryError.invalidResponse
            }
            throw error
        }
        
    }
    
    
}
