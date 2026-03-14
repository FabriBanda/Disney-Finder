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
            
        } catch let error as RepositoryError {
            self.homeState = .failure(error.errorDescription!)
        } catch {
            self.homeState = .failure("There was an error while trying to fetch the characters")
        }
        
    }
    
    func searchCharacters(_ name:String) async {
        
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        self.homeState = .loading
        
        do {
            
            let response = try await self.searchCharactersUseCase.searchCharacter(params: .init(name: trimmedName))
            if response.results.isEmpty {
                self.homeState = .notFound
                return
            }
            
            self.homeState = .success(response.results)
            
            
        } catch let error as SearchCharacterUseCase.SearchCharacterError {
            switch error{
            case .emptyName:
                self.homeState = .failure("You must enter a character name")
            }
        } catch let error as RepositoryError{
            self.homeState = .failure(error.errorDescription!)
        } catch {
            self.homeState = .failure("An unexpected error occurred")
        }
    }
    
}
