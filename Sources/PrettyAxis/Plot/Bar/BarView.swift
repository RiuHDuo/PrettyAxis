//
//  BarView.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/17.
//

import SwiftUI
import Combine

struct BarView: View{
    var plot: BarPlot
    var style: BarStyle
    
    @State var animated: Bool = false
    
    var body: some View{
        if (style.disableLegend == false && plot.groups.contains(NoGroup) == false){
            content(animated: animated)
                .modifier(ScrollableModifier(plot: self.plot, style: self.style))
                .modifier(LegendModifier(list: self.plot.groups.map({($0, style.color[$0] ?? DEFAULT_COLOR)}), style: self.style.legendStyle))
                .onAppear(){
                    withAnimation {
                        animated = true
                    }
                }
        }else{
            content(animated: animated)
                .modifier(ScrollableModifier(plot: self.plot, style: self.style))
                .onAppear(){
                    withAnimation {
                        animated = true
                    }
                }
        }
    }
    
    func content(animated: Bool) -> some View{
        let min = (style.fromZero ? 0 : plot.range.min)
        let range = plot.range.max - min
        let data = plot.renderData
        let animatableValue: CGFloat =  animated ? 1: 0
        return GeometryReader { reader in
            let size = reader.size
            HStack(spacing: 0){
                ForEach(plot.xAxisLabels.indices, id: \.self){ index in
                    let v = data[plot.xAxisLabels[index]]!
                    HStack(spacing: 0){
                        ForEach(v.indices, id: \.self){ i in
                            let value = v[i]
                            let h = (value.0.yValue - min) / range
                            VStack(alignment: .leading, spacing: 0) {
                                if style.showValueLabel{
                                    Text(style.valueLabelStyle.formatter.format(value: value.0.yValue))
                                        .font(style.valueLabelStyle.labelFont)
                                        .foregroundColor(style.valueLabelStyle.labelColor)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.bottom, 4)
                                }
                                Bar(cornerRadius: style.barCornerSize, animatableData: animatableValue)
                                    .fill(style.color[value.1] ?? DEFAULT_COLOR)
                                    .frame(width: style.barWidth, height: h * size.height * animatableValue)
                            }
                            .frame(maxHeight: size.height,alignment: .bottomLeading)
                        }
                    }
                    .padding(.horizontal, style.spacing / 2)
                    .frame(maxWidth: .infinity,alignment: .bottomLeading)
                }
            }
            .frame(maxWidth: .infinity,alignment: .bottomLeading)
        }
        .frame(maxWidth: .infinity,alignment: .bottomLeading)
    }
}

