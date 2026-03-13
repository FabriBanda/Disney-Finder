//
//  MockDataSource.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 08/03/26.
//

import Foundation

struct MockDataSource:DataSource{
    
    func execute<E>(endpoint: E) async throws -> Data where E : Endpoint {
        
        let json = MockJSON.mockJson
        
        guard let data:Data = json.data(using: .utf8) else {
            throw NetworkError.invalidResponse
        }
        
        return data
    }
}
