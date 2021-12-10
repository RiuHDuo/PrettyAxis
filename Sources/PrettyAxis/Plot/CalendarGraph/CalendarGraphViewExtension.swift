//
//  CalendarGraphStyleExtension.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/12/9.
//

import SwiftUI


public extension AxisView where Style == CalendarGraphStyle{
    func blockSize(_ size: CGFloat) -> Self{
        var copy = self
        copy.plotStyle.size = size
        return copy
    }
    
    func blockColor(_ colorable: @escaping (Double) -> Color) -> Self{
        var copy = self
        copy.plotStyle.colorable = colorable
        return copy
    }
    
    func sortYAxis(_ sort: (String, String) -> Bool) -> Self{
        var copy = self
        var plot = copy.plot as! CalendarGraphPlot
        plot.yAxisLabels = plot.yAxisLabels.sorted(by: sort)
        copy.plot = plot
        return copy
    }
    
    func sortXAxis(_ sort: (String, String) -> Bool) -> Self{
        var copy = self
        var plot = copy.plot as! CalendarGraphPlot
        plot.xAxisLabels = plot.xAxisLabels.sorted(by: sort)
        copy.plot = plot
        return copy
    }
    
    func setLegendTitle(leading: String, trailing: String)-> Self{
        var copy = self
        copy.plotStyle.legendLeadingText = leading
        copy.plotStyle.legendTrailingText = trailing
        return copy
    }
}
