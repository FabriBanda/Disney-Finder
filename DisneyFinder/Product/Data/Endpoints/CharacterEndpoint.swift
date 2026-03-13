//
//  CharacterEndpoint.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 07/03/26.
//

import Foundation

struct CharacterEndpoint:Endpoint{
    
    enum EndpointType{
        case allCharacters
        case searchByName(String)
    }
    
    private let type:EndpointType
    
    var path: String {"/character"}
    
    var method: EndpointMethod {.get}
    
    var queryParams: [String : String]? {
        switch type{
        case .allCharacters:
            return nil
        case .searchByName(let name):
            return ["name":name]
        }
    }
    
    init(type: EndpointType) {
        self.type = type
    }
 
}
