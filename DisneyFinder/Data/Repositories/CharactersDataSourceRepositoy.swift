//
//  CharactersDataRepositoy.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 08/03/26.
//

import Foundation

struct CharactersDataSourceRepositoy:CharactersRepository{
    
    private let dataSource:DataSource
    
    init(dataSource: DataSource) {
        self.dataSource = dataSource
    }
    
    func getAllCharacters() async throws -> [CharacterEntity] {
        
        let endpoint:Endpoint = CharacterEndpoint(type: .allCharacters)
        let data:Data? = try await dataSource.execute(endpoint: endpoint)
        
        guard let data else {
            throw RepositoryError.noData
        }
        
        let dtos:[CharacterDTO] = try CharacterDTO.toList(from: data)
        let entities:[CharacterEntity] = dtos.map{$0.toEntity}
        
        return entities

    }
    
    func filterCharacters(name: String) async throws -> [CharacterEntity] {
        
        let endpoint:Endpoint = CharacterEndpoint(type: .searchByName(name))
        let data: Data? = try await dataSource.execute(endpoint: endpoint)
        
        guard let data else {
            throw RepositoryError.noData
        }
        
        let dtos: [CharacterDTO] = try CharacterDTO.toList(from: data)
        let entities: [CharacterEntity] = dtos.map { $0.toEntity }

        return entities
    }
    
    
}
