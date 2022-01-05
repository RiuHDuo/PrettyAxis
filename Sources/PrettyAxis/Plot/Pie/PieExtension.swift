//
//  PieExtension.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/12/1.
//

import SwiftUI

public extension AxisView where Style == PieStyle{
    func stroke<S>(_ s: S, width: CGFloat = 2) -> Self where S: ShapeStyle{
        var copy = self
        copy.plotStyle.color = AnyShapeStyle(s)
        copy.plotStyle.lineWidth = width
        return copy
    }
    
    
    func fill<S>(_ s: [String: S]) -> Self where S: ShapeStyle{
        var copy = self
        
        var fill = copy.plotStyle.fill
        s.keys.forEach { key in
            fill[key] = AnyShapeStyle(s[key]!)
        }
        copy.plotStyle.fill = fill
        return copy
    }
}
