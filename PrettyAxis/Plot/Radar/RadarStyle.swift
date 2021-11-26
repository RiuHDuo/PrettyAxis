//
//  RadarStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/25.
//

import SwiftUI


public struct RadarStyle: ChartStyle{
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
    
    public func createPlot<Input, X>(data: [Input], x: KeyPath<Input, X>, y: KeyPath<Input, Double>, groupBy value: KeyPath<Input, String>?) -> (Self, Plot){
        return (self, RadarPlot(data: data, x: x, y: y, groupBy: value))
    }
}


public extension ChartStyle where Self == RadarStyle{
    static var radar: Self { .init()}
}
