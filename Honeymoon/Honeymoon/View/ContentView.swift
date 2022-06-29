//
//  ContentView.swift
//  Honeymoon
//
//  Created by Ezequiel Rasgido on 29/06/2022.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    @State var showAlert = false
    @State var showGuideView = false
    @State var showInfoView = false
    
    // MARK: - CARDS VIEWS
    
    var cardViews: [CardView] = {
        var views = [CardView]()
        for index in 0..<2 {
            views.append(
                CardView(
                    destination: honeymoonData[index]
                )
            )
        }
        return views
    }()
    
    // MARK: - TOP CARD
    
    private func isTopCard(
        _ cardView: CardView)
    -> Bool {
        guard let index = cardViews.firstIndex(where: {$0.id == cardView.id}) else {
            return false
        }
        return index == 0
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            // MARK: - HEADER
            HeaderView(
                showGuideView: $showGuideView,
                showInfoView: $showInfoView
            )
            
            Spacer()
            
            // MARK: - CARDS
            ZStack {
                ForEach(cardViews) { cardView in
                    cardView
                        .zIndex(self.isTopCard(cardView) ? 1 : 0)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // MARK: - FOOTER
            FooterView(showBookingAlert: $showAlert)
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("SUCCESS"),
                message: Text("Whishing a lovely and most precious of the times together for the amazing couple."),
                dismissButton: .default(Text("Happy Honeymoon!"))
            )
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
