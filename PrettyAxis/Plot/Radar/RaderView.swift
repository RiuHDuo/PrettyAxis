//
//  RaderView.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/25.
//

import SwiftUI


struct RadarView: View{
    var plot: RadarPlot
    var style: RadarStyle
    
    
    @State var animated: Bool = false
    var body: some View{
        let range = (min: style.fromZero  == true ? 0 : plot.range.min, max: plot.range.max)
        GeometryReader{ reader in
            ZStack {
                ForEach(self.plot.xAxisLabels.indices) { index in
                    VStack {
                        Text(self.plot.xAxisLabels[index])
                            .font(style.referenceLineStyle.xAxisLabelFont)
                        Spacer()
                    }
                    .rotationEffect(.radians((Double.pi * 2 * Double(index) / Double(self.plot.xAxisLabels.count))))
                }
                Group {
                    content(size: reader.size, animated: animated)
                    if style.showReferenceLine {
                        RadarReferenceLine(sides: plot.xAxisLabels.count, rounded: style.roundedReference)
                            .stroke(style.referenceLineStyle.axisColor, style: StrokeStyle(lineWidth: style.referenceLineStyle.axisWidth,lineCap: .round, lineJoin: .round))
                        
                        RadarReferenceLine(sides: plot.xAxisLabels.count, rounded: style.roundedReference)
                            .stroke(style.referenceLineStyle.axisColor, style: StrokeStyle(lineWidth: style.referenceLineStyle.axisWidth,lineCap: .round, lineJoin: .round, dash: [10.0]))
                            .frame(width: reader.size.width / 2 , height: reader.size.height / 2)
                        VStack(alignment: .leading, spacing: 0) {
                            let array = [ range.max,  (range.max - range.min) / 2,  range.min,  (range.max - range.min) / 2]
                            ForEach(array, id: \.self){ value in
                                Text(style.referenceLineStyle.formatter.format(value: value))
                                    .font(style.referenceLineStyle.yAxisLabelFont)
                                    .foregroundColor(style.referenceLineStyle.axisLabelColor)
                                Spacer()
                            }
                            Text(style.referenceLineStyle.formatter.format(value: range.max))
                                .font(style.referenceLineStyle.yAxisLabelFont)
                                .foregroundColor(style.referenceLineStyle.axisLabelColor)
                        }
                        .frame(width: reader.size.width / 2, alignment: .leading)
                        .offset(x: reader.size.width / 4 + 4)
                    }
                }
                .padding(30)
                
            }
            .frame(maxWidth: .infinity, maxHeight:.infinity, alignment: .center)
            .onAppear(){
                withAnimation{
                    animated = true
                }
            }
        }
    }
    
    func content(size: CGSize ,animated: Bool) -> some View{
        let keys = Array(self.plot.renderData.keys)
        let range = (min: style.fromZero  == true ? 0 : plot.range.min, max: plot.range.max)
        let animatable: CGFloat = animated ? 1: 0
        return ZStack{
            ForEach(keys, id: \.self){ key in
                ZStack {
                    if let fill = self.style.fill[key]{
                        RadarShape(renderData: plot.renderData[key]!, range: range, animatableData: animatable)
                            .fill(fill)
                    }
                    RadarShape(renderData: plot.renderData[key]!, range: range, animatableData: animatable)
                        .stroke(style.color[key] ?? DEFAULT_COLOR, style: StrokeStyle(lineWidth: style.lineWidth,lineCap: .round, lineJoin: .round))
                }
            }
        }
    }
    
}
