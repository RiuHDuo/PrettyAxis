//
//  AxisStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/26.
//

import SwiftUI


public protocol AxisStyle {
    
    /// The style of Reference line
    ///
    var referenceLineStyle: ReferenceLineStyle {get set}
}


extension AxisStyle {
    
    func copy<S: AxisStyle>(to s: S) -> S{
        var copied = s
        copied.referenceLineStyle = self.referenceLineStyle
        return copied
    }
}
