//
//  DataSource.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 08/03/26.
//

import Foundation

protocol DataSource:Sendable{
    func execute <E: Endpoint>(endpoint:E) async throws -> Data
}
