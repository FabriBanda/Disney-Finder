//
//  SearchCharacterUseCase.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 07/03/26.
//

import Foundation

struct SearchCharacterUseCase{
    
    enum SearchCharacterError: Error {
        case notFound
    }
    
    private let charactersRepository:CharactersRepository
    
    init(charactersRepository: CharactersRepository) {
        self.charactersRepository = charactersRepository
    }
    
    struct Params{
        let name:String
    }
    
    struct Response{
        let results:[CharacterEntity]
    }
    
    func searchCharacter(params:Params) async throws -> Response {
        let characters = try await self.charactersRepository.filterCharacters(name: params.name)
        
        if characters.isEmpty{
            throw SearchCharacterError.notFound
        }
        
        return Response(results: characters)
        
    }
}
