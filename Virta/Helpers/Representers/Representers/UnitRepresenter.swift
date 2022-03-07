//
//  UnitRepresenter.swift
//  Virta
//
//  Created by Ilia Ershov on 07.03.2022.
//

import Foundation

/// A UnitRepresenter defines entity which treats
/// any incoming value as unit of measure and represents it as String.
protocol UnitRepresenter: Representer where Out == String? {

    /// Returns textual unit of measure for incoming value
    ///
    ///
    /// Example:
    ///
    ///     | Unit of measure | Textual representation |
    ///     |-----------------|:----------------------:|
    ///     |      Meter      |           "m"          |
    ///     |       Feet      |          "ft"          |
    ///
    /// - Note:
    ///
    ///     Default unit of measure is empty string
    ///
    /// - Parameter representableValue: Value to present
    func getUnitOfMeasure(forValue representableValue: In) -> String

    /// Returns textual delimeter between value and its' unit of measure
    ///
    /// - Note:
    ///
    ///     Default delimeter is non-breaking space
    ///
    /// - Parameter representableValue: Value to present
    func getUnitSignDelimeter(forValue representableValue: In) -> String
}

extension UnitRepresenter {

    func present(representableValue: In) -> String? {
        let unitOfMeasure = getUnitOfMeasure(forValue: representableValue)
        let unitSignDelimeter = getUnitSignDelimeter(forValue: representableValue)

        let modificator = makeModificator(forValue: representableValue)
        
        guard let modifiedValue = modificator.apply(toValue: representableValue) else { return nil }

        return "\(modifiedValue)\(unitSignDelimeter)\(unitOfMeasure)"
    }

    func getUnitOfMeasure(forValue value: In) -> String {
        return ""
    }

    func getUnitSignDelimeter(forValue value: In) -> String {
        return .nonBreakingSpace
    }
}
