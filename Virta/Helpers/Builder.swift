//
//  Builder.swift
//  Virta
//
//  Created by Ilia Ershov on 05.03.2022.
//

import Foundation

protocol Builder {}

extension Builder {

    func with<V>(_ property: ReferenceWritableKeyPath<Self, V>, setTo value: V) -> Self {
        self[keyPath: property] = value
        return self
    }
}

protocol ConcreteBuilder: Builder {

    associatedtype Buildable

    func build() -> Buildable
}
