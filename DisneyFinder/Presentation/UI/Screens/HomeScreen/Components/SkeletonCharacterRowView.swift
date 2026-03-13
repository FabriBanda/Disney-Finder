//
//  SkeletonCharacterRowView.swift
//  DisneyFinder
//
//  Created by Codex on 13/03/26.
//

import SwiftUI

struct SkeletonCharacterRowView: View {
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.16))
                .frame(width: 90, height: 120)
            
            VStack(alignment: .leading, spacing: 10) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white.opacity(0.16))
                    .frame(width: 120, height: 20)
                
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.white.opacity(0.12))
                    .frame(width: 80, height: 14)
                
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.white.opacity(0.12))
                    .frame(width: 150,height: 14)
            }
            .padding(10)
            
            Spacer()
        }
        .padding()
        .frame(maxHeight: 150)
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 5)
        .redacted(reason: .placeholder)
    }
}
