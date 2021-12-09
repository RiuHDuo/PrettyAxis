//
//  CalendarGraphView.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/12/9.
//

import SwiftUI

struct CalendarGraphView: View {
    
    var plot: CalendarGraphPlot
    var style: CalendarGraphStyle
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack {
                HStack(alignment: .bottom, spacing: 0){
                    if style.showReferenceLine{
                        yAxisView
                    }
                    content
                }
                
                HStack(spacing: 0){
                    Spacer().frame(width: 20)
                    ForEach(plot.xAxisLabels, id: \.self){ data in
                        Text(data)
                            .font(self.style.labelStyle.labelFont)
                            .foregroundColor(self.style.labelStyle.labelColor)
                            .frame(width: self.style.labelWidth, height: self.style.labelStyle.labelHeight, alignment: .center)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var yAxisView: some View{
        VStack(spacing: 0){
            ForEach(plot.yAxisLabels.indices){ index in
                Text(plot.yAxisLabels[index])
                    .font(style.referenceLineStyle.yAxisLabelFont)
                    .foregroundColor(style.referenceLineStyle.axisLabelColor)
                    .frame(height: style.size + style.spacing, alignment: .center)
            }
        }
        .frame(maxHeight: .infinity, alignment: .bottomTrailing)
    }
    
    @ViewBuilder
    var content: some View {
        let range = plot.range.max - plot.range.min
        HStack(spacing: style.spacing){
            ForEach(plot.xAxisLabels.indices) { index in
                let x = plot.xAxisLabels[index]
                VStack(spacing: style.spacing){
                    ForEach(plot.yAxisLabels.indices){ index in
                        let y = plot.yAxisLabels[index]
                        let data = plot.renderData[x]![y]
                        let v = CGFloat(data?.zValue ?? 0) / CGFloat(range)
                        RoundedRectangle(cornerRadius: 2)
                            .foregroundColor(style.colorable(v))
                            .frame(width: style.size, height: style.size, alignment: .center)
                    }
                }
            }
        }
    }
}
