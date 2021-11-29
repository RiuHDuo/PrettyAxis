//
//  BarStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/17.
//

import SwiftUI


public struct BarStyle: ChartStyle{
    public func createPlot<Input>(data: [Input]) -> (BarStyle, Plot) where Input : Axisable {
        let plot = BarPlot(data: data)
        var copy = self
        copy.count = plot.groups.count
        return (copy,plot)
    }
    

    var barWidth: CGFloat = 15
    
    var color: [String: AnyShapeStyle] = [NoGroup: AnyShapeStyle(Color.blue)]
    
    var barCornerSize: CGFloat = 2.0
    
    var showValueLabel: Bool = false
    
    var valueLabelFont: Font = Font.system(size: 8)
    
    var valueLabelColor = Color.black
    
    var formatter:NumberFormatter = .int
    
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


public extension ChartStyle where Self == BarStyle{
    static var bar: Self { .init() }
}
