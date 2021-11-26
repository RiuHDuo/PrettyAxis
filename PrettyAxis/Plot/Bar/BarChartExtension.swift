//
//  BarChartExtension.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/17.
//

import SwiftUI


public extension ChartView where Style == BarStyle{
    func fill<S>(_ s: S) -> Self where S: ShapeStyle{
        var copy = self
        let plot = self.plot as? BarPlot
        plot?.groups.forEach { e in
            copy.plotStyle.color[e] = AnyShapeStyle(s)
        }
        return copy
    }
    
    
    func fill<S>(_ s: [String: S]) -> Self where S: ShapeStyle{
        var copy = self
        var color = copy.plotStyle.color
        s.keys.forEach { key in
            color[key] = AnyShapeStyle(s[key]!)
        }
        copy.plotStyle.color = color
        return copy
    }
    
    
    func barWidth(_ width: CGFloat) -> Self{
        var copy = self
        copy.plotStyle.barWidth = width
        return copy
    }
    
    
    func enableValueLabel(enable: Bool, font: Font = Font.system(size: 8), color: Color = Color.black, formatter: NumberFormatter = .int) -> Self{
        var copy = self
        copy.plotStyle.showValueLabel = enable
        copy.plotStyle.valueLabelColor = color
        copy.plotStyle.valueLabelFont = font
        copy.plotStyle.formatter = formatter
        return copy
    }
}
