//
//  ButtonModifier.swift
//  Honeymoon
//
//  Created by Ezequiel Rasgido on 29/06/2022.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .frame(minWidth: 0 , maxWidth: .infinity)
            .background(Capsule().fill(.pink))
            .foregroundColor(.white)
    }
}
