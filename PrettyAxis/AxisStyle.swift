//
//  AxisStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/26.
//

import SwiftUI

/// Style of AxisView
/// 
public protocol AxisStyle {
    
    /// The style of Reference line.
    ///
    var referenceLineStyle: ReferenceLineStyle {get set}
    
    /// The style of mark's floating label.
    ///
    var markLabelStyle: MarkLabelStyle {get set}
}


extension AxisStyle {
    func copy<S: AxisStyle>(to s: S) -> S{
        var copied = s
        copied.referenceLineStyle = self.referenceLineStyle
        copied.markLabelStyle = self.markLabelStyle
        return copied
    }
}
