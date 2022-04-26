//
//  ReferenceLineStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/24.
//

import SwiftUI


/// Style of Reference Line
///
public struct ReferenceLineStyle{
    
    /// Font of x-axis label
    public var xAxisLabelFont: Font = .system(size: 14)
    
    /// Color of x-axis label
    public var xAxisLabelColor: Color = .gray
    
    /// Hide the x-axis label
    public var hideXAxisLabel: Bool = false
    
    /// Hight of X-axis
    public var xAxisHeight: CGFloat = 32
    
    /// Font of x-axis label
    public var yAxisLabelFont: Font = .system(size: 14)
    
    /// Color of x-axis label
    public var yAxisLabelColor: Color = .gray
    
    /// Hide the x-axis label
    public var hideYAxisLabel: Bool = false

    /// Formatter of y axis value
    public var valueFormatter: ValueFormatter = .int
    
    /// Width of Y-Axis
    public var yAxisWidth: CGFloat = 48
    
    /// The width of reference dash line width
    public var dashLineWidth: CGFloat = 1
    
    /// The lengths of painted and unpainted segments used to make a dashed line.
    public var dashLineLength: CGFloat = 10
    
    /// The width of x axis line
    public var xAxisLineWidth: CGFloat = 1
    
    /// The width of y axis line
    public var yAxisLineWidth: CGFloat = 1
}


public extension ReferenceLineStyle {
    static var `default`: Self{
        return ReferenceLineStyle()
    }
}


extension ReferenceLineStyle{
    var leadingPadding: CGFloat{
        self.yAxisWidth + self.yAxisLineWidth
    }
}
