//
//  LineExtension.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/18.
//

import SwiftUI


public extension AxisView where Style == LineStyle{
    func lineWidth(width: CGFloat) -> Self{
        var copy = self
        copy.plotStyle.lineWidth = width
        return copy
    }
    
    func lineType(type: LineType) -> Self{
        var copy = self
        copy.plotStyle.type = type
        return copy
    }
    
    func stroke<S>(_ s: S) -> Self where S: ShapeStyle{
        var copy = self
        let plot = self.plot as! LinePlot
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
    
    func fill<S>(_ s: S) -> Self where S: ShapeStyle{
        var copy = self
        let plot = self.plot as! LinePlot
        plot.renderData.keys.forEach { key in
            copy.plotStyle.fill[key]  = AnyShapeStyle(s)
        }
        return copy
    }
    
    func fill<S>(_ s: [String: S]) -> Self where S: ShapeStyle{
        var copy = self
        
        var fill = copy.plotStyle.fill
        s.keys.forEach { key in
            fill[key] = AnyShapeStyle(s[key]!)
        }
        copy.plotStyle.fill = fill
        return copy
    }
    
    func showMark<S>(_ m: [String: MarkType], fill s: [String: S]) -> Self  where S: ShapeStyle{
        var copy = self
        var fill = copy.plotStyle.markFill
        s.keys.forEach { key in
            fill[key] = AnyShapeStyle(s[key]!)
            copy.plotStyle.marks[key] = m[key]
        }
        copy.plotStyle.marks[NoGroup] = m[NoGroup]
        fill[NoGroup] = fill[NoGroup]
        copy.plotStyle.markFill = fill
        return copy
    }
    
    func showMark<S>(_ m: MarkType, fill s: S) -> Self  where S: ShapeStyle{
        var copy = self
        let plot = self.plot as! LinePlot
        plot.renderData.keys.forEach { key in
            copy.plotStyle.markFill[key]  = AnyShapeStyle(s)
            copy.plotStyle.marks[key] = m
        }
        return copy
    }
}
