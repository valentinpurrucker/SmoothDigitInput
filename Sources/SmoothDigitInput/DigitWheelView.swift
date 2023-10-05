//
//  DigitWheelView.swift
//  SmoothDigitInput
//
//  Created by Valentin Purrucker on 04.10.23.
//

import SwiftUI

struct DigitInputWheelView: View {
    
    static let defaultOffset = 4.5
    
    let number: Int
    
    @State var size: CGSize = .zero

    init(_ number: Int) {
        self.number = number
    }
    
    private var offset: CGFloat {
        size.height * (Self.defaultOffset - CGFloat(number))
    }
    
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                ForEach(0..<10) { i in
                    Text("\(i)")
                        .measureSize()
                        .onPreferenceChange(SizePreference.self) { size in
                            self.size = size
                        }
                }
            }
            .offset(y: offset)
        }
    }
}

#Preview {
    DigitInputWheelView(5)
}
