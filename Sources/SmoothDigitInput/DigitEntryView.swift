//
//  DigitEntryView.swift
//  SmoothDigitInput
//
//  Created by Valentin Purrucker on 04.10.23.
//

import SwiftUI

struct DigitEntryView: View {
    let digitEntry: DigitInputEntry
    
    let isFirst: Bool
    
    let decimalSeperator: String
    
    let groupingSeperator: String
    
    init(_ digitEntry: DigitInputEntry, isFirst: Bool, decimalSeperator: String, groupingSeperator: String) {
        self.digitEntry = digitEntry
        self.isFirst = isFirst
        self.decimalSeperator = decimalSeperator
        self.groupingSeperator = groupingSeperator
    }
    
    var body: some View {
        HStack {
            switch digitEntry.input {
            case .number(let number):
                if isFirst {
                    DigitInputWheelView(number)
                } else {
                    Text("\(number)")
                        .measureSize()
                }
            case .grouping:
                Text("\(groupingSeperator)")
                    .measureSize()
            case .decimal:
                Text("\(decimalSeperator)")
                    .measureSize()
            }
        }
    }
}

#Preview {
    DigitEntryView(DigitInputEntry(), isFirst: false, decimalSeperator: ".", groupingSeperator: ",")
}
