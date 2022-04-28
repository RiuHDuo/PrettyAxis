//
//  AxisPaintStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/27.
//

import SwiftUI

public struct AxisPaintStyle{
    var stroke: AnyShapeStyle
    var fill: AnyShapeStyle?
    
    public init<S: ShapeStyle,F: ShapeStyle>(stroke: S, fill: F){
        self.stroke = AnyShapeStyle(stroke)
        self.fill = AnyShapeStyle(fill)
    }
    
    public init<S: ShapeStyle>(stroke: S){
        self.stroke = AnyShapeStyle(stroke)
        self.fill = nil
    }
}



public extension AxisPaintStyle {
    static var `default`: Self {
        .init(stroke: Color.blue)
    }
}
