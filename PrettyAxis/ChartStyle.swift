//
//  PlotStyle.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/17.
//

import SwiftUI

let RANGE_FACTOR: CGFloat = 1.05
let DEFAULT_COLOR = AnyShapeStyle(Color.red)

public protocol ChartStyle{
    var spacing: CGFloat {get set}
    var labelWidth: CGFloat {get}
    var showReferenceLine: Bool {get set}
    
    var labelStyle: LabelStyle {get set}
    
    var referenceLineStyle: ReferenceLineStyle { get set}
    
    var fromZero: Bool {get set}
    
    associatedtype Body : View
    func contentView(plot: Plot) -> Body
    
    func createPlot<Input>(data: [Input]) -> (Self, Plot) where Input: Axisable
}



