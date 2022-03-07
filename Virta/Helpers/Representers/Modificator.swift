//
//  Modificator.swift
//  Virta
//
//  Created by Ilia Ershov on 07.03.2022.
//

import Foundation

/// A Modificator defines an entity that transforms incoming value of one type into another
///
/// Usage:
///
///     struct NumberStringifyModificator: Modificator {
///
///         func apply(toValue value: Double) -> String {
///             return String(value)
///         }
///     }
///
protocol Modificator {

    associatedtype In
    associatedtype Out

    /// Modification method. Applies some transformation on incoming value and returns new one
    /// - Parameter value: Value to modify
    /// - Returns: Modified value
    func apply(toValue value: In) -> Out
}

extension Modificator {

    func asClosure() -> ClosureModificator<In, Out> {
        return ClosureModificator<In, Out>(apply(toValue:))
    }
}

/// Basic modificator that should be initialized with modification closure
struct ClosureModificator<In, Out>: Modificator {

    /// Modification closure
    private let closure: (In) -> Out

    /// Initialize `ClosureModificator` with specified closure
    /// - Parameter closure: Modification closure to use
    init(_ closure: @escaping (In) -> Out) {
        self.closure = closure
    }

    /// Modifies incoming value with help of initialized closure
    /// - Parameter value: Value to modify
    /// - Returns: Modified value
    func apply(toValue value: In) -> Out {
        return closure(value)
    }
}

precedencegroup AssociativityLeft {

    associativity: left
}

infix operator >>> : AssociativityLeft

/// Combines two `Modificator` entities
/// - Parameter lhs: Left side `Modificator` entity
/// - Parameter rhs: Right side `Modificator` entity
/// - Returns: `ClosureModificator` which composes two `apply` methods inside itself
func >>> <A: Modificator, B: Modificator>(lhs: A, rhs: B) -> ClosureModificator<A.In, B.Out> where A.Out == B.In {
    return ClosureModificator { data in rhs.apply(toValue: lhs.apply(toValue: data)) }
}
