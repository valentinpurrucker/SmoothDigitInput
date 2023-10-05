//
//  DigitStore.swift
//  SmoothDigitInput
//
//  Created by Valentin Purrucker on 04.10.23.
//

import Foundation

@Observable
public class DigitStore {

    private(set) var inputEntries: [DigitInputEntry]

    var useGrouping: Bool = true

    public private(set) var isFirstSet = false

    var decimalSeperator: String = "."

    var groupingSeperator: String = ","

    public init(_ defaultNumberEntry: Int = 0) {
        inputEntries = [DigitInputEntry(.number(defaultNumberEntry))]
    }

    public init(_ defaultEntries: [Int]) {
        inputEntries = defaultEntries.map {
            DigitInputEntry(.number($0))
        }
    }

    @discardableResult
    public func add(_ number: Int) -> Bool {
        add(.number(number))
    }

    @discardableResult
    public func addDecimal() -> Bool {
        add(.decimal)
    }

    private func add(_ input: DigitInput) -> Bool {

        if case .decimal = input, (hasDecimal() || !isFirstSet) {
            return false
        }

        if case .number(_) = input, !isFirstSet {
            let replacedInitial = DigitInputEntry(input, id: inputEntries[0].id)
            inputEntries[0] = replacedInitial
        } else {
            let newInputEntry = DigitInputEntry(input)
            inputEntries.append(newInputEntry)
        }

        isFirstSet = true

        if useGrouping {
            insertGroupingParts()
        }

        return true
    }

    @discardableResult
    public func remove() -> Bool {
        if inputEntries.count == 1 {
            if !isFirstSet {
                return false
            }
            let newInitial = DigitInputEntry(id: inputEntries[0].id)
            inputEntries[0] = newInitial
            isFirstSet = false

            return true
        } else {
            _ = inputEntries.removeLast()
        }

        if useGrouping {
            insertGroupingParts()
        }

        return true
    }

    public func hasDecimal() -> Bool {
        inputEntries.firstIndex {
            switch $0.input {
            case .decimal:
                return true
            default: return false
            }
        } != nil
    }

    public func getNumber() -> Double? {
        let numberPartValues = inputEntries
            .filter {
                switch $0.input {
                case .grouping: return false
                default: return true
                }
            }
            .map {
                switch $0.input {
                case .number(let num):
                    return "\(num)"
                case .decimal:
                    return decimalSeperator
                case .grouping:
                    return groupingSeperator
                }
            }

        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = decimalSeperator

        return numberFormatter.number(from: numberPartValues.joined())?.doubleValue
    }

    private func getDecimalIndex(inputs: [DigitInputEntry]) -> Int? {
        inputs.firstIndex(where: {
            switch $0.input {
            case .decimal:
                return true
            default: return false
            }
        })
    }


    private func insertGroupingParts() {

        guard let number = getNumber() else {
            return
        }

        var numberAsInt = Int(number)
        var thousands = 0

        var groupedNumberEntries = inputEntries
        groupedNumberEntries = groupedNumberEntries.filter {
            switch $0.input {
            case .grouping:
                return false
            default: return true
            }
        }

        var end = groupedNumberEntries.count

        if let decimalIndex = getDecimalIndex(inputs: groupedNumberEntries) {
            end -= groupedNumberEntries.count - decimalIndex
        }

        while numberAsInt >= 1000 {
            numberAsInt = numberAsInt / 1000
            thousands += 1

            let groupingEntryIndex = end - 3 * thousands

            groupedNumberEntries.insert(DigitInputEntry(.grouping), at: groupingEntryIndex)
        }

        for i in 0..<min(groupedNumberEntries.count, inputEntries.count) {
            if case .grouping = inputEntries[i].input {
                if case .grouping = groupedNumberEntries[i].input {
                    let newGrouping = DigitInputEntry(.grouping, id: inputEntries[i].id)
                    groupedNumberEntries[i] = newGrouping
                }
            }
        }

        inputEntries = groupedNumberEntries
    }
}
