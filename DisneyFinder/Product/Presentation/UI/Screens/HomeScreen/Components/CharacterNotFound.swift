//
//  CharacterNotFound.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 13/03/26.
//

import SwiftUI

struct CharacterNotFound: View {
    var body: some View {
        HStack(){
            Spacer()
            VStack(alignment: .center, spacing: 15){
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 55))
                Text("No se encontraron personajes con ese nombre ")
                    .font(.body)
            }
            Spacer()
        }
        .foregroundStyle(.white)
    }
}

