//
//  AnyTransition+DigitInputTransition.swift
//  SmoothDigitInput
//
//  Created by Valentin Purrucker on 04.10.23.
//

import SwiftUI

extension AnyTransition {
    static var smoothNumberTransition: AnyTransition {
        AnyTransition.asymmetric(insertion: .modifier(active: DigitTransition(isActive: true), identity: DigitTransition(isActive: false)), removal: .move(edge: .bottom))
    }
    
    static var smoothAccessoryTransition: AnyTransition {
        .move(edge: .bottom)
    }
}
