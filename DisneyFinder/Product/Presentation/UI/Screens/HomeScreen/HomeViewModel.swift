//
//  HomeViewModel.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 08/03/26.
//

import Foundation
import Combine

@MainActor
@Observable
class HomeViewModel{
    
    enum HomeState{
        case idle
        case loading
        case success([CharacterEntity])
        case notFound
        case failure(String)
    }
    
    var homeState:HomeState = .idle
    let skeletonCount:Int = 5
    
    var displayed:[CharacterEntity]{
        switch homeState {
        case .idle:
            return []
        case .loading:
            return []
        case .success(let characters):
            return characters
        case .notFound:
            return []
        case .failure:
            return []
        }
    }

    var isLoading: Bool {
        if case .loading = self.homeState {
            return true
        }
        return false
    }

    var errorMessage: String? {
        if case .failure(let message) = self.homeState {
            return message
        }
        return nil
    }
    
    private let getAllCharactersUseCase: GetAllCharactersUseCase
    private let searchCharactersUseCase:SearchCharacterUseCase
  
   
    init(getAllCharactersUseCase: GetAllCharactersUseCase,searchCharactersUseCase:SearchCharacterUseCase) {
        self.getAllCharactersUseCase = getAllCharactersUseCase
        self.searchCharactersUseCase = searchCharactersUseCase
    }
    
    func getAllCharacters() async {
        
        self.homeState = .loading
        
        do{
            let response = try await self.getAllCharactersUseCase.getAllCharacters()
            self.homeState = .success(response.results)
        }catch{
            self.homeState = .failure("Hubo un error al intentar obtener los personajes")
        }
        
    }
    
    func searchCharacters(_ name:String) async {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        self.homeState = .loading
        
        do {
            let response = try await self.searchCharactersUseCase.searchCharacter(params: .init(name: trimmedName))
            self.homeState = .success(response.results)
            
        } catch SearchCharacterUseCase.SearchCharacterError.notFound{
            self.homeState = .notFound
        }
        catch{
            self.homeState = .failure("Hubo un error al intentar obtener el personaje \(trimmedName)")
        }
    }
}
