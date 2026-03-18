//
//  GetAllCharactersUseCase.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 07/03/26.
//

import Foundation


struct GetAllCharactersUseCase{
    
    private let charactersRepository:CharactersRepository
    
    enum GetAllCharacterError: Error{
        case noDataAvailable
    }
    
    init(charactersRepository: CharactersRepository) {
        self.charactersRepository = charactersRepository
    }
    
    struct Response{
        let results: [CharacterEntity]
    }
    
    func getAllCharacters() async throws -> Response{
        
        let characters = try await charactersRepository.getAllCharacters()
    
        if characters.isEmpty{
            throw GetAllCharacterError.noDataAvailable
        }
        
        return Response(results: characters)
    }
    
    
}
