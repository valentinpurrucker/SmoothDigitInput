//
//  DigitEntry.swift
//  SmoothDigitInput
//
//  Created by Valentin Purrucker on 04.10.23.
//

import Foundation

enum DigitInput {
    case number(Int)
    case grouping
    case decimal
}

struct DigitInputEntry: Identifiable {
    
    let id: UUID
    
    let input: DigitInput
    
    init(_ input: DigitInput = .number(0), id: UUID = UUID()) {
        self.id = id
        self.input = input
    }
    
    func isNumber() -> Bool {
        switch input {
        case .number(_):
            return true
        default:
            return false
        }
    }
}


