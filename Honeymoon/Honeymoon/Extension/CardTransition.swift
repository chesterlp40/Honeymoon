//
//  CardTransition.swift
//  Honeymoon
//
//  Created by Ezequiel Rasgido on 29/06/2022.
//

import SwiftUI

extension AnyTransition {
    static var trailingBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity,
            removal: AnyTransition.move(
                edge: .trailing
            ).combined(
                with: .move(edge: .bottom)
            )
        )
    }
    
    static var leadingBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .identity,
            removal: AnyTransition.move(
                edge: .leading
            ).combined(
                with: .move(edge: .bottom)
            )
        )
    }
}
