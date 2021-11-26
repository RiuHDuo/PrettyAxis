//
//  ScatterExtension.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/26.
//

import SwiftUI


public extension ChartView where Style == ScatterStyle{
    func stroke<S>(_ s: S) -> Self where S: ShapeStyle{
        var copy = self
        let plot = self.plot as! ScatterPlot
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
        let plot = self.plot as! ScatterPlot
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
}
