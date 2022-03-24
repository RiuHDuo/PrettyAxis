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
            VStack(spacing:0) {
                if !style.disableLegend {
                    HStack{
                        Text(style.legendLeadingText)
                            .font(style.legendStyle.font)
                            .foregroundColor(style.legendStyle.labelColor)
                        let r = min(style.legendStyle.iconSize * 0.2, 4)
                        ForEach((0 ..< 5).indices, id: \.self){ index in
                            RoundedRectangle(cornerRadius: r)
                                .strokeBorder(Color.gray)
                                .background(style.colorable(0.2 * Double(index)))
                                .cornerRadius(r)
                                .frame(width: style.legendStyle.iconSize, height: style.legendStyle.iconSize, alignment: .center)
                        }
                        Text(style.legendTrailingText)
                            .font(style.legendStyle.font)
                            .foregroundColor(style.legendStyle.labelColor)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 16)
                }
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
                            .font(style.labelStyle.labelFont)
                            .foregroundColor(style.labelStyle.labelColor)
                            .frame(width: style.labelWidth, height: style.labelStyle.labelHeight, alignment: .center)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var yAxisView: some View{
        VStack(spacing: 0){
            ForEach(plot.yAxisLabels.indices, id: \.self){ index in
                Text(plot.yAxisLabels[index])
                    .font(style.referenceLineStyle.yAxisLabelFont)
                    .foregroundColor(style.referenceLineStyle.axisLabelColor)
                    .frame(height: style.size + style.spacing, alignment: .center)
                    .padding(.trailing, 4)
            }
        }
        .frame(maxHeight: CGFloat(plot.yAxisLabels.count) * style.labelWidth, alignment: .bottomTrailing)
    }
    
    @ViewBuilder
    var content: some View {
        let range = plot.range.max - plot.range.min
        HStack(spacing: style.spacing){
            ForEach(plot.xAxisLabels.indices, id: \.self) { index in
                let x = plot.xAxisLabels[index]
                VStack(spacing: style.spacing){
                    ForEach(plot.yAxisLabels.indices, id: \.self){ index in
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
