//
//  SizePreference.swift
//  SmoothDigitInput
//
//  Created by Valentin Purrucker on 05.10.23.
//

import Foundation
import SwiftUI


struct SizePreference: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct MeasureSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { geo in
                    Color.clear
                        .preference(key: SizePreference.self, value: geo.size)
                }
            }
    }
}

extension View {
    func measureSize() -> some View {
        self
            .modifier(MeasureSizeModifier())
    }
}
