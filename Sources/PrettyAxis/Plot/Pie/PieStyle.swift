//
//  File.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/24.
//

import SwiftUI


public struct PieStyle: AxisStyle{
    public var legendStyle = LegendStyle()
    
    public var disableLegend: Bool = true
    
    public var color =  AnyShapeStyle(DEFAULT_COLOR)
    
    public var fill:[String: AnyShapeStyle] = [:]
    
    public var spacing: CGFloat = 0
     
    public var labelWidth: CGFloat = 0
    
    public var lineWidth: CGFloat = 2
    
    public var showReferenceLine = false
    
    public var labelStyle: LabelStyle  = AxisLabelStyle()
    
    public var referenceLineStyle = ReferenceLineStyle.default
    
    public var enableOuterReferenceLine = false
    
    public var fromZero: Bool = true
    
    public func contentView(plot: Plot) -> some View{
        return PieView(plot: plot as! PiePlot, style: self)
    }
    
    public func createPlot<Input>(data: [Input]) -> (PieStyle, Plot) where Input : Axisable {
        return (self, PiePlot(data: data))
    }
    
    var innerRadiusPercent: CGFloat = 1
}


public extension AxisStyle where Self == PieStyle{
    static var pie: Self { .init() }
    
    static func doughnut(innerRadiusPercent: CGFloat) -> Self {
        var ret = PieStyle()
        var p = innerRadiusPercent
        if p > 1 {
            p = 1
        }else if p < 0{
            p = 0
        }
        ret.innerRadiusPercent = innerRadiusPercent
        return ret
    }
}
