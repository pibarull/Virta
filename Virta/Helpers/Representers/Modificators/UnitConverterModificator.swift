//
//  UnitConverterModificator.swift
//  Virta
//
//  Created by Ilia Ershov on 07.03.2022.
//

import Foundation

/// A UnitConverterModificator converts incoming value from one unit to another
///
/// Usage:
///
///     // Kilometers to meters
///     let modificator = UnitConverterModificator(incomingUnit: UnitLength.kilometers,
///                                                outcomingUnit: UnitLength.meters)
///
///     modificator.apply(toValue: 5) // Output: 5000
///
struct UnitConverterModificator: Modificator {

    let incomingUnit: Dimension
    let outcomingUnit: Dimension

    func apply(toValue value: Double) -> Double {
        return Measurement(value: value, unit: incomingUnit).converted(to: outcomingUnit).value
    }
}
