//
//  Injector.swift
//  Virta
//
//  Created by Ilia Ershov on 06.03.2022.
//

import Foundation

/// A wrapper around dependency injection mechanism.
///
/// Acts as a factory for injected types.
/// Should be extended with help of `where clause`.
///
/// Example:
///
///     extension Injector where T == SomeProtocol {
///
///         static func inject(someArgument: Any) -> SomeProtocol {
///             return SomeEntity()
///         }
///     }
///
enum Injector<T> {}
