//
//  CharacterRowView.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 09/03/26.
//

import SwiftUI

struct CharacterRowView: View {
    
    let name:String
    let imageUrl:String?
    let films:[String]
    
    var body: some View {
            VStack(alignment: .center){
                HStack{
                    
                    if let imageUrl = self.imageUrl {
                        AsyncImage(url: URL(string:imageUrl)) { image in
                            image
                                .resizable()
                                .modifier(ImageModifier())
                            
                        } placeholder: {
                            Image(.default)
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(0.7)
                        }
                    }else{
                        Image(.default)
                            .resizable()
                            .modifier(ImageModifier())
                    }
 
                    VStack(alignment: .leading){
                        
                        Text(self.name)
                            .font(.title3)
                            .foregroundStyle(Color.white)
                            .fontWeight(.bold)
                    
                        VStack(alignment: .leading){
                            Text("Films")
                                .font(.subheadline)
                                .foregroundStyle(Color.white)
                            
                            ScrollView(.horizontal) {
                                HStack{
                                    ForEach(self.films.indices,id:\.self){ index in
                                        Text("\(index+1). \(films[index]) ")
                                            .foregroundStyle(Color.white.opacity(0.7))
                                    }
                                }
                            }.scrollIndicators(.hidden)
                            
                        }.padding(.top,1)

                      
                        
                        Spacer()
                    }.padding(10)
                   
                    Spacer()
                }
            }.padding()
             .frame(maxHeight: 150)
             .background(Color.gray.opacity(0.1),in:RoundedRectangle(cornerRadius: 20))
             .padding(.horizontal,5)
            
    }
}

struct ImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(maxWidth: 90,maxHeight: 120)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
