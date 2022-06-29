//
//  TitleModifier.swift
//  Honeymoon
//
//  Created by Ezequiel Rasgido on 29/06/2022.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.pink)
    }
}
