//
//  DisneyFinderApp.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 07/03/26.
//

import SwiftUI

@main
struct DisneyFinderApp: App {
    
    let dependencies:DependencyInjector = DependencyInjector()
    
    var body: some Scene {
        WindowGroup {
            HomeScreen(
                getAllCharactersUseCase: dependencies.getAllCharactersUseCase,
                searchCharactersUseCase: dependencies.searchCharactersUseCase
            )
        }
    }
}
