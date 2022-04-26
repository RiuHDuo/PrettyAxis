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
    
    /// The style of axis
    ///
    var axisStyle: AxisStyle { get set }
}



extension AxisView {
    
    /// Hide reference line
    ///
    ///- Returns: A AxisView which hide the reference line.
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
    ///- Returns: A AxisView drawn reference line with the specified style.
    func referenceLineStyle(_ style: ReferenceLineStyle) -> Self{
        var copy = self
        copy.plot.axisStyle.referenceLineStyle = style
        return copy
    }
    
}
