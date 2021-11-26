//
//  ChartView.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/15.
//

import SwiftUI


public struct ChartView<Input, Style>: View where Input: Any, Style: ChartStyle{
    @State var animated = false
    var plot: Plot
    var plotStyle:Style
    
    public init<X>(style: Style, data: [Input], x: KeyPath<Input, X>, y: KeyPath<Input, Double>, groupBy value: KeyPath<Input, String>? = nil){
        let r = style.createPlot(data: data, x: x, y: y, groupBy: value)
        self.plot = r.1
        self.plotStyle = r.0
    }
    
    
    public var body: some View{
        self.plotStyle.contentView(plot: self.plot)
    }
    
}
