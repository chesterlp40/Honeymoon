//
//  HeaderView.swift
//  Honeymoon
//
//  Created by Ezequiel Rasgido on 29/06/2022.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - PROPERTIES
    
    @Binding var showGuideView: Bool
    @Binding var showInfoView: Bool
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Button {
                self.showInfoView.toggle()
            } label: {
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .regular))
            }
            .tint(.primary)

            Spacer()
            
            Image("logo-honeymoon-pink")
                .resizable()
                .scaledToFit()
                .frame(height: 28)
            
            Spacer()
            
            Button {
                self.showGuideView.toggle()
            } label: {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 24, weight: .regular))
            }
            .tint(.primary)
        }
        .sheet(isPresented: $showGuideView) {
            GuideView()
        }
        .sheet(isPresented: $showInfoView) {
            InfoView()
        }
        .padding()
    }
}

// MARK: - PREVIEW
struct HeaderView_Previews: PreviewProvider {
    @State static var showGuideView = false
    @State static var showInfoView = false
    
    static var previews: some View {
        HeaderView(
            showGuideView: $showGuideView,
            showInfoView: $showInfoView
        )
            .previewLayout(
                .fixed(
                    width: 375,
                    height: 80
                )
            )
    }
}
