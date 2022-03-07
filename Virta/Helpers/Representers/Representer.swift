//
//  Representer.swift
//  Virta
//
//  Created by Ilia Ershov on 07.03.2022.
//

/// A Representer defines an entity which represents one value as another with help of `Modificator`
///
/// Usage:
///
///     struct ClampedNumberRepresenter: Representer {
///
///         let maxValue: Double
///
///         func makeModificator(forValue representableValue: Double) -> ClosureModificator<Double, String> {
///             return ClosureModificator { return $0 > self.maxValue ? self.maxValue : $0 }
///                 >>> ClosureModificator { String($0) }
///         }
///     }
///
protocol Representer {

    associatedtype In
    associatedtype Out

    /// Returns represented value
    /// - Parameter representableValue: Value to present
    /// - Returns: Represented value
    func present(representableValue: In) -> Out

    /// Returns `ClosureModificator` that modifies value to expected output type
    /// - Parameter representableValue: Value to present
    /// - Returns: `ClosureModificator` to use for value modification
    func makeModificator(forValue representableValue: In) -> ClosureModificator<In, Out>
}

extension Representer {

    func present(representableValue: In) -> Out {
        let modificator = makeModificator(forValue: representableValue)
        return modificator.apply(toValue: representableValue)
    }
}
