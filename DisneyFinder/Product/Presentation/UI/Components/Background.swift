//
//  Background.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 09/03/26.
//

import SwiftUI

struct Background: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 10/255, green: 47/255, blue: 61/255),  
                    Color(red: 12/255, green: 79/255, blue: 89/255)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            RadialGradient(
                colors: [
                    Color(red: 25/255, green: 183/255, blue: 181/255).opacity(0.8),
                    Color.clear
                ],
                center: .bottom,
                startRadius: 50,
                endRadius: 500
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Background()
}
