//
//  RepositoryError.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 13/03/26.
//

import Foundation

enum RepositoryError:LocalizedError{
    case noInternetConnection
    case networkConnectionLost
    case cannotConnectToHost
    case cannotFindHost
    case invalidUrl
    case invalidResponse
    case noData
    case httpStatus(_ httpCode:Int)
    
    var errorDescription: String?{
        switch self {
        case .noInternetConnection:
            return "No internet connection"
        case .invalidUrl:
            return "The URL is invalid"
        case .invalidResponse:
            return "The server response is invalid"
        case .noData:
            return "No data was returned"
        case .networkConnectionLost:
            return "The network connection was lost"
        case .cannotConnectToHost:
            return "Could not connect to the server"
        case .cannotFindHost:
            return "Could not find the server"
        case .httpStatus(_):
            return "Server error"
        }
    }
}
