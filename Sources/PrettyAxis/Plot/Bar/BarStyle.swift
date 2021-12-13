//
//  BarStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/17.
//

import SwiftUI


public struct BarStyle: AxisStyle{
    public func createPlot<Input>(data: [Input]) -> (BarStyle, Plot) where Input : Axisable {
        let plot = BarPlot(data: data)
        var copy = self
        copy.count = plot.groups.count
        return (copy,plot)
    }
    
    public var legendStyle = LegendStyle()
    
    public var disableLegend: Bool = true
    

    var barWidth: CGFloat = 15
    
    var color: [String: AnyShapeStyle] = [NoGroup: AnyShapeStyle(Color.blue)]
    
    var barCornerSize: CGFloat = 2.0
    
    var showValueLabel: Bool = false
    
    var valueLabelStyle = AxisLabelStyle()
    
    var count = 1
    
    public var labelWidth: CGFloat {
        return  barWidth * CGFloat(count) + spacing
    }
    
    public var spacing: CGFloat = 30
    
    public var showReferenceLine = false
    
    public var labelStyle: LabelStyle  = AxisLabelStyle()
    
    public var referenceLineStyle = ReferenceLineStyle.default
    
    public var fromZero: Bool = true
    
    public func contentView(plot: Plot) -> some View{
       return  BarView(plot: plot as! BarPlot, style: self)
    }
}


public extension AxisStyle where Self == BarStyle{
    static var bar: Self { .init() }
}
