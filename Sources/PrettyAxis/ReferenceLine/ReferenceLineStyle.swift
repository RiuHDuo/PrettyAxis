//
//  ReferenceStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/17.
//

import SwiftUI

public struct ReferenceLineStyle{
    public var axisColor: AnyShapeStyle
    public var axisWidth: CGFloat = 1
    public var yAxisLabelFont:Font
    public var xAxisLabelFont:Font
    public var formatter : NumberFormatter
    public var axisLabelColor: Color
    
    public init<S>(axisColor: S, axisWidth: CGFloat = 1, axisLabelColor: Color = Color.init(red: 174 / 255.0, green: 174 / 255.0, blue:  178 / 255.0), xAxisLabelFont: Font = Font.system(size: 8), yAxisLabelFont: Font = Font.system(size: 8), formatter: NumberFormatter = .int) where S: ShapeStyle{
        self.axisColor = AnyShapeStyle(axisColor)
        self.axisWidth = axisWidth
        self.yAxisLabelFont = yAxisLabelFont
        self.formatter = formatter
        self.axisLabelColor = axisLabelColor
        self.xAxisLabelFont = xAxisLabelFont
    }
}


public extension ReferenceLineStyle{
    static var `default`: Self {
        ReferenceLineStyle(axisColor: Color.init(red: 174 / 255.0, green: 174 / 255.0, blue:  178 / 255.0))
    }
}


