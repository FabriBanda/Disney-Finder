//
//  _Endpoint.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 07/03/26.
//

import Foundation

protocol Endpoint{
    var path:String {get}
    var method:EndpointMethod {get}
    var queryParams:[String:String]? {get}
    var headers: [String:String]? {get}
}

extension Endpoint {
    var queryParams: [String: String]? { nil }
    var headers: [String: String]? { nil }
}

enum EndpointMethod{
    case delete
    case get
    case post
    case put
}
