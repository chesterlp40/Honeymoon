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
    
    // MARK: - BODY
    var body: some View {
        VStack {
            HeaderView(
                showGuideView: $showGuideView,
                showInfoView: $showInfoView
            )
            
            Spacer()
            
            CardView(destination: honeymoonData[3])
                .padding()
            
            Spacer()
            
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
