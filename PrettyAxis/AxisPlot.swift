//
//  AxisViewType.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/24.
//

import SwiftUI


public protocol AxisPlot: View{
    /// Hide reference line
    ///
    ///If value is true, will no render reference line
    var hideReferenceLine: Bool {get set}
    
    var hideLegend: Bool {get set}
    
    /// The style of axis
    ///
    var axisStyle: AxisStyle { get set }
    
    
}



public extension AxisView {
    
    /// Hide reference line
    ///
    ///- Returns: An AxisView which hide the reference line.
    func hideReferenceLine() -> Self{
        var copy = self
        copy.plot.hideReferenceLine = true
        return copy
    }
    
    /// Set reference line style.
    ///
    ///- Parameters:
    ///     - style: A ReferenceLineStyle that AxisView uses to draw the reference line.
    ///
    ///- Returns: An AxisView drawn reference line with the specified style.
    func referenceLineStyle(_ style: ReferenceLineStyle) -> Self{
        var copy = self
        copy.plot.axisStyle.referenceLineStyle = style
        return copy
    }
    
    func hideLegend()-> Self{
        var copy = self
        copy.plot.hideLegend = true
        return copy
    }
    
    
    func legendStyle(_ style: LegendStyle) -> Self {
        var copy = self
        copy.plot.axisStyle.legendStyle = style
        return copy
    }
}


extension AxisPlot {
    func calcRange(range: (min: Double, max: Double), xAxisValue: Double?, scaleFactor: Double = 1.05) -> (min: Double, max: Double){
        var axisValue:Double = 0
        if let xAxisValue = xAxisValue {
            axisValue = xAxisValue
        }else{
            if range.max < 0{
                axisValue = range.max
            }else if range.min > 0{
                axisValue = range.min
            }
        }
        
        if range.min >= axisValue {
            return (min: axisValue, max: range.max * scaleFactor)
        }
    
        if range.max <= axisValue{
            return (min: range.min * scaleFactor, max: axisValue)
        }
        let v = max(abs(axisValue - range.min) * scaleFactor,abs(range.max - axisValue) * scaleFactor )
        
        return (min: axisValue - v, max: axisValue + v)

    }
}
