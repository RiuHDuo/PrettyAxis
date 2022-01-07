//
//  RadarExtension.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/25.
//

import SwiftUI

public extension AxisView where Style == RadarStyle{
    
    func fill<S>(_ s: [String: S]) -> Self where S: ShapeStyle{
        var copy = self
        var color = copy.plotStyle.color
        s.keys.forEach { key in
            color[key] = AnyShapeStyle(s[key]!)
        }
        copy.plotStyle.fill = color
        return copy
    }
    
    func lineWidth(_ width: CGFloat) -> Self{
        var copy = self
        copy.plotStyle.lineWidth = width
        return copy
    }
    
    func stroke<S>(_ s: S) -> Self where S: ShapeStyle{
        var copy = self
        let plot = self.plot as! RadarPlot
        plot.renderData.keys.forEach { key in
            copy.plotStyle.color[key]  = AnyShapeStyle(s)
        }
        return copy
    }
    
    func stroke<S>(_ s: [String: S]) -> Self where S: ShapeStyle{
        var copy = self
        var color = copy.plotStyle.color
        s.keys.forEach { key in
            color[key] = AnyShapeStyle(s[key]!)
        }
        copy.plotStyle.color = color
        return copy
    }
    
    
    func setMaxValue(_ value: Double) -> Self{
        var copy = self
        var plot = copy.plot as! RadarPlot
        plot.range = (min: plot.range.min, max: value)
        copy.plot = plot
        return copy
    }
    
    func roundedReferenceLine() -> Self{
        var copy = self
        copy.plotStyle.roundedReference = true
        return copy
    }
    
    func xLabelOffset(_ offset: CGFloat) -> Self{
        var copy = self
        copy.plotStyle.xLabelOffset = offset
        return copy
    }

}
