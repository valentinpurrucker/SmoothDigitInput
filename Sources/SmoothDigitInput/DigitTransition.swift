//
//  DigitTransition.swift
//  SmoothDigitInput
//
//  Created by Valentin Purrucker on 04.10.23.

import SwiftUI

struct DigitTransition: ViewModifier {
    
    let isActive: Bool

    let verticalOffset: CGFloat

    func body(content: Content) -> some View {
        content
            .offset(x: isActive ? 40 : 0, y: isActive ? verticalOffset : 0)
    }
}

struct DigitRemovalTransition: ViewModifier {

    let isActive: Bool

    let verticalOffset: CGFloat

    func body(content: Content) -> some View {
        content
            .offset(y: isActive ? verticalOffset : 0)
    }
}
