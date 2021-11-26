//
//  LineStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/18.
//

import Foundation
import SwiftUI

public struct LineStyle: ChartStyle{
    var lineWidth: CGFloat = 1.0
    
    var color = [NoGroup: AnyShapeStyle(Color.blue)]
    
    var type: LineType = .smooth(curviness: 0.35)
    
    var fill:[String: AnyShapeStyle] = [:]
    
    var marks:[String: MarkType] = [:]
    
    var markFill:[String: AnyShapeStyle] = [:]
    
    
    public var labelWidth: CGFloat {
        return self.spacing
    }
    
    public var spacing: CGFloat = 50
    
    public var showReferenceLine = false
        
    public var labelStyle: LabelStyle  = AxisLabelStyle()
    
    public var referenceLineStyle = ReferenceLineStyle.default
    
    public var fromZero: Bool = true
    
    public func contentView(plot: Plot) -> some View{
       return  LineView(plot: plot as! LinePlot, style: self)
    }
    
    public func createPlot<Input, X>(data: [Input], x: KeyPath<Input, X>, y: KeyPath<Input, Double>, groupBy value: KeyPath<Input, String>?) -> (Self, Plot){
        return (self, LinePlot(data: data, x: x, y: y, groupBy: value))
    }
}


public extension ChartStyle where Self == LineStyle{
    static var line: Self { .init() }
}
