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
    
    enum HomeState {
        case idle
        case loading
        case success([CharacterEntity])
        case notFound
    }
    
    struct ErrorBanner:Identifiable,Equatable {
        let id = UUID()
        let message:String
    }
    
    var homeState:HomeState = .idle
    var displayedCharacters:[CharacterEntity] = []
    var visibleError: ErrorBanner?
    let skeletonCount:Int = 5
    
    var isLoading:Bool{
        if case .loading = homeState {
            return true
        }
        return false
    }
    
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
        }
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
            self.displayedCharacters = response.results
            
        } catch let error as RepositoryError {
            self.visibleError = .init(message: error.errorDescription ?? "An error occurred")
            self.homeState = .success(displayedCharacters)
        } catch {
            self.visibleError = .init(message: "There was an error while trying to fetch the characters")
            self.homeState = .idle
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
            self.displayedCharacters = response.results
            
        } catch let error as SearchCharacterUseCase.SearchCharacterError {
            
            switch error{
                
            case .emptyName:
                self.visibleError = .init(message: "You must enter a character name")
                if !self.displayedCharacters.isEmpty{
                    self.homeState = .success(displayedCharacters)
                }else{
                    self.homeState = .idle
                }
                
            }
            
        } catch let error as RepositoryError{
            self.visibleError = .init(message: error.errorDescription ?? "An unexpected error occurred")
            self.homeState = .success(displayedCharacters)
        } catch {
            self.visibleError = .init(message: "An unexpected error ocurred")
            self.homeState = .idle
        }
    }
    
    func clearVisibleError(){
        self.visibleError = nil
    }
    
}
