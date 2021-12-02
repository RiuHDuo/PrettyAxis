//
//  LineStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/18.
//

import Foundation
import SwiftUI

public struct LineStyle: AxisStyle{
    public func createPlot<Input>(data: [Input]) -> (LineStyle, Plot) where Input : Axisable {
        return (self, LinePlot(data: data))
    }
    
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
    
    public var legendStyle = LegendStyle()
    
    public var disableLegend: Bool = true
}


public extension AxisStyle where Self == LineStyle{
    static var line: Self { .init() }
}
