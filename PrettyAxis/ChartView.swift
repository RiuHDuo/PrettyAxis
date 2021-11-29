//
//  ChartView.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/15.
//

import SwiftUI


public struct ChartView<Input, Style>: View where Input: Axisable, Style: ChartStyle{
    @State var animated = false
    var plot: Plot
    var plotStyle:Style
    
    public init(style: Style, data: [Input]){
        let r = style.createPlot(data: data)
        self.plot = r.1
        self.plotStyle = r.0
    }
    
    
    public var body: some View{
        self.plotStyle.contentView(plot: self.plot)
    }
}
