//
//  SearchButton.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 12/03/26.
//

import SwiftUI

struct SearchButton: View {
    
    var disable:Bool
    let action:() -> Void
  
    var body: some View {
        VStack{
            Button {
                self.action()
            } label: {
                Image(systemName: "magnifyingglass")
                    .opacity(self.disable ? 0.5:1)
                    .font(.body)
            }.padding()
             .glassEffect()
             .clipShape(Circle())
          //   .disabled(self.disable)
        }
    }
}
