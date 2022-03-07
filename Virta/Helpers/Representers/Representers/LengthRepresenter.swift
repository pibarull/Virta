//
//  LengthRepresenter.swift
//  Virta
//
//  Created by Ilia Ershov on 07.03.2022.
//

import Foundation

/// A `LengthRepresenter` present length as a string.
///
/// Example:
///
///     // Meters
///     99 -> "99 m"
///     1501 -> "1,5 km"
///
struct LengthRepresenter: UnitRepresenter {

    private enum Constants {
        static let defaultValue = "--"
        static let thousandsOfUnits: Double = 1000
        static let hundredsOfUnits: Double = 100
        static let singleUnit: Double = 1
        static let zeroUnit: Double = 0
    }

    let unitOfMeasure: UnitLength

    func makeModificator(forValue representableValue: Double?) -> ClosureModificator<Double?, String?> {
        guard let representableValue = representableValue else {
            return ClosureModificator { _ in Constants.defaultValue }
        }

        let convertationalUnit = getConvertationalUnit(forValue: representableValue)

        return ClosureModificator { $0! }
            >>> UnitConverterModificator(incomingUnit: UnitLength.meters, outcomingUnit: convertationalUnit)
            >>> ClosureModificator {

                let fractionDigits = self.getFractionDigits(forValue: $0, withUnit: convertationalUnit)

                return NumberFormatterModificator(minimumFractionDigits: fractionDigits,
                                                  maximumFractionDigits: fractionDigits,
                                                  useDefaultSeparator: true).apply(toValue: $0)
            }
    }

    func getUnitOfMeasure(forValue value: Double?) -> String {
        guard let value = value else { return unitOfMeasure.symbol }
        let unit = getConvertationalUnit(forValue: value)
        return unit.symbol
    }

    private func getConvertationalUnit(forValue representableValue: Double) -> UnitLength {
        let convertedValue = UnitConverterModificator(incomingUnit: UnitLength.meters,
                                                      outcomingUnit: unitOfMeasure).apply(toValue: representableValue)
        if convertedValue < Constants.thousandsOfUnits {
            return unitOfMeasure
        }

        switch unitOfMeasure {
        case .meters:
            return .kilometers
        case .feet:
            return .miles
        default:
            return unitOfMeasure
        }
    }

    private func getFractionDigits(forValue representableValue: Double, withUnit unit: UnitLength) -> Int {
        switch unit {
        case .kilometers, .miles:
            return 1
        default:
            return 0
        }
    }
}
