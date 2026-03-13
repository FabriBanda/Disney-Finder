//
//  CharacterDTO.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 07/03/26.
//

import Foundation

struct CharacterDTO:Decodable{
    let _id:Int
    let name:String
    let imageUrl:String?
    let films:[String]
}

extension CharacterDTO{
    static func toList(from data:Data) throws -> [CharacterDTO] {
        let decoder:JSONDecoder = JSONDecoder()
        let response:CharactersResponseDTO = try decoder.decode(CharactersResponseDTO.self, from: data)
        return response.data
    }
}


extension CharacterDTO{
    var toEntity:CharacterEntity{
        CharacterEntity(
            // mapear de DTO a entity
            _id: self._id,
            name: self.name,
            imageUrl: self.imageUrl ?? "",
            films: self.films)
    }
}

//extension CharacterDTO{
//    static func toObject(from data:Any) -> CharacterDTO? {
//        if let json:[String:Any] = data as? [String:Any] {
//            let character: CharacterDTO = CharacterDTO(
//                
//                _id: json["_id"] as? Int ?? 0,
//                name: json["name"] as? String ?? "",
//                imageUrl: json["imageUrl"] as? String ?? "",
//                films: json["films"] as? [String] ?? []
//                
//                )
//            return character
//        }
//        
//        return nil
//    }
//}
