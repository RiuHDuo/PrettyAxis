//
//  RadarStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/25.
//

import SwiftUI


public struct RadarStyle: ChartStyle{
    public func createPlot<Input>(data: [Input]) -> (RadarStyle, Plot) where Input : Axisable {
        return (self, RadarPlot(data: data))
    }
    
    public var spacing: CGFloat = 0
    
    public var labelWidth: CGFloat = 0
    
    public var showReferenceLine: Bool = false
    
    public var labelStyle: LabelStyle = AxisLabelStyle()
    
    public var referenceLineStyle: ReferenceLineStyle = .default
    
    public var fromZero: Bool = true
    
    
    var roundedReference: Bool = false

    var lineWidth: CGFloat = 1
    
    var fill:[String: AnyShapeStyle] = [:]
    
    var color = [NoGroup: AnyShapeStyle(Color.blue)]
    
    public func contentView(plot: Plot) -> some View{
        return  RadarView(plot: plot as! RadarPlot, style: self)
    }
    
    public var legendStyle = LegendStyle()
    
    public var disableLegend: Bool = true

}


public extension ChartStyle where Self == RadarStyle{
    static var radar: Self { .init()}
}
