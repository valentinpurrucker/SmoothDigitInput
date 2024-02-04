//
//  SmoothDigitInputView.swift
//  SmoothDigitInput
//
//  Created by Valentin Purrucker on 04.10.23.
//

import SwiftUI

public struct SmoothDigitInputView<PrefixContent: View, SuffixContent: View>: View {
    private let animation: Animation

    private let verticalPadding: CGFloat

    private let spacing: CGFloat

    private let store: DigitStore

    private let numberTransition: AnyTransition?

    private let accessoryTransition: AnyTransition

    @State private var size: CGSize = .zero

    let prefixContent: PrefixContent

    let suffixContent: SuffixContent

    public init(_ store: DigitStore,
                spacing: CGFloat = 0.0,
                decimalSeperator: String? = nil,
                groupingSeperator: String? = nil,
                useGrouping: Bool = true,
                animation: Animation = .interactiveSpring,
                verticalPadding: CGFloat = 0.0,
                numberTransition: AnyTransition? = nil,
                accessoryTransition: AnyTransition? = nil,
                @ViewBuilder prefixContent: () -> PrefixContent,
                @ViewBuilder suffixContent: () -> SuffixContent) {
        self.store = store
        self.animation = animation
        self.verticalPadding = verticalPadding
        self.spacing = spacing
        self.numberTransition = numberTransition
        self.accessoryTransition = accessoryTransition ?? .smoothAccessoryTransition

        self.store.decimalSeperator = decimalSeperator ?? Locale.current.decimalSeparator ?? "."
        self.store.groupingSeperator = groupingSeperator ?? Locale.current.groupingSeparator ?? ","
        self.store.useGrouping = useGrouping

        self.prefixContent = prefixContent()
        self.suffixContent = suffixContent()
    }

    public var body: some View {

        let numTransition = self.numberTransition ?? getNumberTransition()

        HStack(spacing: spacing) {

            prefixContent

            let enumertedDigits = Array(zip(store.inputEntries.indices, store.inputEntries))
            ForEach(enumertedDigits, id: \.1.id) { (i, digit) in
                DigitEntryView(digit, isFirst: i == 0, decimalSeperator: store.decimalSeperator, groupingSeperator: store.groupingSeperator)
                    .transition(digit.isNumber() ? numTransition : accessoryTransition)
            }

            suffixContent
        }
        .frame(height: size.height + verticalPadding)
        .frame(maxWidth: .infinity)
        .onPreferenceChange(SizePreference.self) { size in
            self.size = size
        }
        .clipped()
    }

    private func getNumberTransition() -> AnyTransition {
        AnyTransition.asymmetric(insertion: .modifier(active: DigitTransition(isActive: true, verticalOffset: size.height), identity: DigitTransition(isActive: false, verticalOffset: size.height)), removal: .modifier(active: DigitRemovalTransition(isActive: true, verticalOffset: size.height), identity: DigitRemovalTransition(isActive: false, verticalOffset: size.height)))
    }
}

#Preview {
    SmoothDigitInputView(DigitStore()) {

    } suffixContent: {

    }
}
