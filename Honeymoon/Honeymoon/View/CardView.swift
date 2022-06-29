//
//  CardView.swift
//  Honeymoon
//
//  Created by Ezequiel Rasgido on 29/06/2022.
//

import SwiftUI

struct CardView: View {
    // MARK: - PROPERTIES
    
    let id = UUID()
    var destination: Destination
    
    // MARK: - BODY
    var body: some View {
        Image(destination.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(24)
            .frame(
                minWidth: 0,
                maxWidth: .infinity
            )
            .overlay(
                VStack(alignment: .center, spacing: 12) {
                    Text(destination.country.uppercased())
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(radius: 1)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 4)
                        .overlay(
                            Rectangle()
                                .fill(.white)
                                .frame(height: 1),
                            alignment: .bottom
                        )
                    Text(destination.place.uppercased())
                        .foregroundColor(.black)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .frame(minWidth: 85)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(.white)
                        )
                }
                    .frame(minWidth: 280)
                    .padding(.bottom, 50),
                alignment: .bottom
            )
    }
}

// MARK: - PREVIEW
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(destination: honeymoonData[1])
            .previewLayout(
                .fixed(
                    width: 375,
                    height: 600
                )
            )
    }
}
