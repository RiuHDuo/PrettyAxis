//
//  CalendarGraphStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/12/9.
//

import SwiftUI

public struct CalendarGraphStyle: AxisStyle{
    public var spacing: CGFloat = 1
    
    public var labelWidth: CGFloat {
        size + spacing
    }
    
    public var showReferenceLine: Bool = false
    
    public var labelStyle: LabelStyle = AxisLabelStyle()
    
    public var referenceLineStyle: ReferenceLineStyle =  ReferenceLineStyle.default
    
    public var fromZero: Bool = true
    
    public var legendStyle: LegendStyle = LegendStyle()
    
    var legendLeadingText = "less"
    var legendTrailingText = "more"
    
    public var disableLegend: Bool = true
    
    public var size: CGFloat = 50
    
    public func createPlot<Input>(data: [Input]) -> (CalendarGraphStyle, Plot) where Input : Axisable {
        let plot = CalendarGraphPlot(data: data)
        return (self,plot)
    }
    
    public func contentView(plot: Plot) -> some View{
        return  CalendarGraphView(plot: plot as! CalendarGraphPlot, style: self)
    }
    

    var colorable:(Double) -> Color =  { value in 
        return Color(hue: 0.24, saturation: value, brightness: 1)
    }
}

public extension AxisStyle where Self == CalendarGraphStyle{
    static var calendarGraph: Self { .init()}
}
