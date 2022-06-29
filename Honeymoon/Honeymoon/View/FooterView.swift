//
//  FooterView.swift
//  Honeymoon
//
//  Created by Ezequiel Rasgido on 29/06/2022.
//

import SwiftUI

struct FooterView: View {
    // MARK: - PROPERTIES
    
    @Binding var showBookingAlert: Bool
    
    private let haptic = UINotificationFeedbackGenerator()
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Image(systemName: "xmark.circle")
                .font(.system(size: 42, weight: .light))

            Spacer()
            
            Button {
                playSound(sound: "sound-click", type: "mp3")
                self.haptic.notificationOccurred(.success)
                self.showBookingAlert.toggle()
            } label: {
                Text("Book destination".uppercased())
                    .font(
                        .system(
                            .subheadline,
                            design: .rounded
                        )
                    )
                    .fontWeight(.heavy)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 12)
                    .tint(.pink)
                    .background(
                        Capsule().stroke(.pink, lineWidth: 4)
                    )
            }
            
            Spacer()
            
            Image(systemName: "heart.circle")
                .font(.system(size: 42, weight: .light))
        }
        .padding()
    }
}

// MARK: - PREVIEW
struct FooterView_Previews: PreviewProvider {
    @State static var showAlert = false
    
    static var previews: some View {
        FooterView(showBookingAlert: $showAlert)
            .previewLayout(
                .fixed(
                    width: 375,
                    height: 80
                )
            )
    }
}
