//
//  Optional+.swift
//  Virta
//
//  Created by Ilia Ershov on 05.03.2022.
//

import Foundation

extension Optional {

    /// Applies closure if value is present
    /// - Parameter closure: Closure to apply
    func apply(_ closure: (Wrapped) -> Void) {
        if let value = self {
            closure(value)
        }
    }
}
