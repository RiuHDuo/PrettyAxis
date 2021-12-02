//
//  ChartViewExtension.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/25.
//

import SwiftUI

public extension AxisView{
    func referenceLine(style: ReferenceLineStyle = .default) -> Self{
        var copy = self
        copy.plotStyle.showReferenceLine = true
        copy.plotStyle.referenceLineStyle = style
        return copy
    }
    
    func labelFont(_ font: Font) -> Self{
        var copy = self
        copy.plotStyle.labelStyle.labelFont = font
        return copy
    }
    
    func labelColor(_ color: Color) -> Self{
        var copy = self
        copy.plotStyle.labelStyle.labelColor = color
        return copy
    }
    
    
    func spacing(_ spacing: CGFloat) -> Self{
        var copy = self
        copy.plotStyle.spacing = spacing
        return copy
    }
    
    func fromZero(_ isFromZero: Bool) -> Self{
        var copy = self
        copy.plotStyle.fromZero = isFromZero
        return copy
    }
    
    func enableLegend(_ enable: Bool, style: LegendStyle?) -> Self{
        var copy = self
        copy.plotStyle.disableLegend = !enable
        if let style = style {
            copy.plotStyle.legendStyle = style
        }
        return copy
    }
}
