//
//  DependencyInjector.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 09/03/26.
//

import Foundation

final class DependencyInjector {
    
    let dataSource: DataSource
    let charactersRepository: CharactersRepository
    let getAllCharactersUseCase: GetAllCharactersUseCase
    let searchCharactersUseCase: SearchCharacterUseCase

    init(useMockDataSource: Bool = false) {
        let selectedDataSource: DataSource = useMockDataSource ? MockDataSource() : HttpDataSource(host: Constants.Network.baseURL)

        self.dataSource = selectedDataSource
        self.charactersRepository = CharactersDataSourceRepositoy(dataSource: selectedDataSource)
        self.getAllCharactersUseCase = GetAllCharactersUseCase(charactersRepository: self.charactersRepository)
        self.searchCharactersUseCase = SearchCharacterUseCase(charactersRepository: self.charactersRepository)
    }

}
