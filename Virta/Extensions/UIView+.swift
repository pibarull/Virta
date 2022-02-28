//
//  UIView+.swift
//  Virta
//
//  Created by Ilia Ershov on 28.02.2022.
//

import Foundation
import UIKit

extension UIView {

    var width: CGFloat {
        return frame.size.width
    }

    var height: CGFloat {
        return frame.size.height
    }

    var top: CGFloat {
        return frame.origin.y
    }

    var left: CGFloat {
        return frame.origin.x
    }

    var bottom: CGFloat {
        return top + height
    }

    var right: CGFloat {
        return left + width
    }
}
