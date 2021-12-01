//
//  PieView.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/30.
//

import SwiftUI

struct PieView: View {
    var plot: PiePlot
    var style: PieStyle
    var body: some View {
        if style.disableLegend {
            content
        }else{
            content.modifier(LegendModifier(list: plot.xAxisLabels.map({($0, style.fill[$0] ?? DEFAULT_COLOR)}), style: LegendStyle()))
        }
    }
    
    var content: some View {
        var angles:[ (Double, Double)] = []
        var angle: Double = 0
        self.plot.renderData.forEach { item in
            let end = item.yValue * 360 + angle
            angles.append((angle, end))
            angle = end
        }
        return GeometryReader{ reader in
            let r = min(reader.size.width, reader.size.height) / 2
            ZStack{
                ForEach(angles.indices){ index in
                    let ang2 = angles[index]
                    if let fill = style.fill[self.plot.xAxisLabels[index]]{
                        PieSlice(radius: r, startAngle: .degrees(ang2.0), endAngle: .degrees(ang2.1))
                            .fill(fill)
                    }
                    
                    if style.showReferenceLine{
                        let angle = Angle(degrees: (ang2.0 + ang2.1) / 2)
                        VStack {
                            Text(plot.xAxisLabels[index])
                                .font(style.referenceLineStyle.xAxisLabelFont)
                                .foregroundColor(Color.white)
                            
                            Text(style.referenceLineStyle.formatter.format(value: plot.renderData[index].yValue))
                                .font(style.referenceLineStyle.xAxisLabelFont)
                                .foregroundColor(Color.white)
                        }
                        .offset(x: r * 0.6 * cos(angle.radians), y: r * 0.6 * sin(angle.radians))
                    }
                    
                    PieSlice(radius: r, startAngle: .degrees(ang2.0), endAngle: .degrees(ang2.1))
                        .stroke(Color.white, lineWidth: 2)
                }
            }
        }
    }
}
