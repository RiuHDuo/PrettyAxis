//
//  BarChartExtension.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/17.
//

import SwiftUI


public extension AxisView where Style == BarStyle{
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
        copy.plotStyle.valueLabelStyle = AxisLabelStyle(labelHeight: 20, labelFont: font, labelColor: color, formatter: formatter)
        return copy
    }

    
    func sortXAxis(by sort: (String, String) -> Bool) -> Self{
        var copy = self
        var plot = copy.plot as! BarPlot
    
        let xlabels = plot.xAxisLabels
        plot.xAxisLabels = xlabels.sorted(by: sort)

        copy.plot = plot
        return copy
    }
}
