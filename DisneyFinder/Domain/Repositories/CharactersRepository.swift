//
//  CharacterRepository.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 07/03/26.
//

import Foundation

protocol CharactersRepository {
    func getAllCharacters() async throws -> [CharacterEntity]
    func filterCharacters(name:String) async throws -> [CharacterEntity]
}
