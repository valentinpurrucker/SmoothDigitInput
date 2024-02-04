//
//  AnyTransition+DigitInputTransition.swift
//  SmoothDigitInput
//
//  Created by Valentin Purrucker on 04.10.23.
//

import SwiftUI

extension AnyTransition {
    
    static var smoothAccessoryTransition: AnyTransition {
        .move(edge: .bottom)
    }
}
