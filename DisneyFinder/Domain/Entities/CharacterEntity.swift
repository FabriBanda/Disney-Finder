//
//  CharacterEntity.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 07/03/26.
//

import Foundation

struct CharacterEntity:Codable{
    let _id:Int
    let name:String
    let imageUrl:String?
    let films:[String]
}

extension CharacterEntity{
    static let placeholder:[CharacterEntity] = [
        CharacterEntity(_id: 1, name: "Mickey Mouse", imageUrl: nil, films: ["Fantasia", "Fun and Fancy Free"]),
        CharacterEntity(_id: 2, name: "Minnie Mouse", imageUrl: nil , films: ["Mickey's Once Upon a Christmas", "The Wonderful World of Mickey Mouse"]),
        CharacterEntity(_id: 3, name: "Donald Duck", imageUrl: nil, films: ["Fantasia 2000", "Saludos Amigos"]),
        CharacterEntity(_id: 4, name: "Goofy", imageUrl: nil, films: ["A Goofy Movie", "An Extremely Goofy Movie"]),
        CharacterEntity(_id: 5, name: "Goofy", imageUrl: nil, films: ["A Goofy Movie", "An Extremely Goofy Movie"])

    ]

    
}
