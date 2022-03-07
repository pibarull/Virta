//
//  NumberFormatterModificator.swift
//  Virta
//
//  Created by Ilia Ershov on 07.03.2022.
//

import Foundation

/// A NumberFormatterModificator modifies incoming `Double` value
/// according to set up `NumberFormatter` class
struct NumberFormatterModificator: Modificator {

    private enum Constants {

        static let defaultMinimumIntegerDigits = 1
        static let defaultSeparator = ","
    }

    let minimumFractionDigits: Int
    let maximumFractionDigits: Int

    /// Minimum amount of integer digits. Set to `1` by default.
    let minimumIntegerDigits: Int

    /// Rule by which numbers should be rounded. Set to `down` by default.
    let roundingMode: NumberFormatter.RoundingMode

    /// Indicates that modificator uses default `dot` separator instead of localized once.
    let useDefaultSeparator: Bool

    func apply(toValue value: Double) -> String? {
        let formatter = makeNumberFormatter()
        return formatter.string(from: NSNumber(value: value))
    }

    /// Returns set up `NumberFormatter`
    private func makeNumberFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()

        formatter.minimumFractionDigits = minimumFractionDigits
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.minimumIntegerDigits = minimumIntegerDigits

        formatter.roundingMode = roundingMode

        if useDefaultSeparator {
            formatter.decimalSeparator = Constants.defaultSeparator
        }

        return formatter
    }
}

extension NumberFormatterModificator {

    init(minimumFractionDigits: Int, maximumFractionDigits: Int, useDefaultSeparator: Bool = false) {
        self.minimumFractionDigits = minimumFractionDigits
        self.maximumFractionDigits = maximumFractionDigits
        self.roundingMode = .halfEven
        self.minimumIntegerDigits = Constants.defaultMinimumIntegerDigits
        self.useDefaultSeparator = useDefaultSeparator
    }
}
