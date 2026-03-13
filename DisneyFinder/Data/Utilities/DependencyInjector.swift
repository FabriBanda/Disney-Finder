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
    
//     static let shared = DependencyInjector()
//
//    private var dependencies: [String: Any] = [:]
//    private let useMockDataSource: Bool
//
//    private init(useMockDataSource: Bool = false) {
//        self.useMockDataSource = useMockDataSource
//        self.injectDependencies()
//    }
//
//    static func bootstrap(useMockDataSource: Bool = false) -> DependencyInjector {
//        DependencyInjector(useMockDataSource: useMockDataSource)
//    }
//
//    private func registerSingletonDependency<T>(_ service: T, key: String? = nil) {
//        let key = key ?? "\(T.self)"
//        self.dependencies[key] = service
//    }
//
//    private func registerDependency<T>(_ factory: @escaping () -> T, key: String? = nil) {
//        let key = key ?? "\(T.self)"
//        self.dependencies[key] = factory
//    }
//
//    func getDependency<T>(key: String? = nil) -> T? {
//        let key = key ?? "\(T.self)"
//
//        if let singleton = self.dependencies[key] as? T {
//            return singleton
//        }
//
//        if let factory = self.dependencies[key] as? () -> T {
//            return factory()
//        }
//
//        return nil
//    }
//
//    private func injectDependencies() {
//        self.injectSources()
//        self.injectRepositories()
//        self.injectUseCases()
//    }
//
//    private func injectSources() {
//        self.registerSingletonDependency(HttpDataSource() as DataSource, key: "HttpDataSource")
//        self.registerSingletonDependency(MockDataSource() as DataSource, key: "MockDataSource")
//    }
//
//    private func injectRepositories() {
//        let key = self.useMockDataSource ? "MockDataSource" : "HttpDataSource"
//        let selectedDataSource: DataSource = self.getDependency(key: key)!
//
//        self.registerDependency {
//            CharactersDataSourceRepositoy(dataSource: selectedDataSource) as CharactersRepository
//        }
//    }
//
//    private func injectUseCases() {
//        let charactersRepository: CharactersRepository = self.getDependency()!
//
//        self.registerDependency {
//            GetAllCharactersUseCase(charactersRepository: charactersRepository)
//        }
//
//        self.registerDependency {
//            SearchCharacterUseCase(charactersRepository: charactersRepository)
//        }
//    }
}
