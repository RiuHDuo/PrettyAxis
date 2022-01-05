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
        if style.innerRadiusPercent < 1{
            if style.disableLegend {
                doughnutContent
            }else{
                doughnutContent.modifier(LegendModifier(list: plot.xAxisLabels.map({($0, style.fill[$0] ?? DEFAULT_COLOR)}), style: style.legendStyle))
            }
        }else{
            if style.disableLegend {
                content
            }else{
                content.modifier(LegendModifier(list: plot.xAxisLabels.map({($0, style.fill[$0] ?? DEFAULT_COLOR)}), style: style.legendStyle))
            }
        }
    }
    
    private var angles: [ (Double, Double)] {
        var angles:[ (Double, Double)] = []
        var angle: Double = 0
        self.plot.renderData.forEach { item in
            let end = item.yValue * 360 + angle
            angles.append((angle, end))
            angle = end
        }
        return angles
    }
    
    var doughnutContent: some View{
        return GeometryReader{ reader in
            let r = min(reader.size.width, reader.size.height) / 2
            ZStack{
                ForEach(angles.indices){ index in
                    let ang2 = angles[index]
                    if let fill = style.fill[self.plot.xAxisLabels[index]]{
                        DoughnutSlice(radius: r, innerRadius: r * style.innerRadiusPercent, startAngle: .degrees(ang2.0), endAngle: .degrees(ang2.1))
                            .fill(fill)
                    }
                    
                    if style.showReferenceLine{
                        let angle = Angle(degrees: (ang2.0 + ang2.1) / 2)
                        VStack {
                            Text(plot.xAxisLabels[index])
                                .font(style.referenceLineStyle.xAxisLabelFont)
                                .foregroundColor(Color.white)
                                .shadow(radius: 2)
                            
                            Text(style.referenceLineStyle.formatter.format(value: plot.renderData[index].yValue))
                                .font(style.referenceLineStyle.xAxisLabelFont)
                                .foregroundColor(Color.white)
                                .shadow(radius: 2)
                        }
                        .offset(x: r * (style.innerRadiusPercent / 2 +  0.5) * cos(angle.radians), y: r * (style.innerRadiusPercent / 2 +  0.5) * sin(angle.radians))
                    }
                    
                    DoughnutSlice(radius: r, innerRadius: r * style.innerRadiusPercent, startAngle: .degrees(ang2.0), endAngle: .degrees(ang2.1))
                        .stroke(Color.white, lineWidth: 2)
                }
            }
        }
    }
    
    var content: some View {
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
                                .shadow(radius: 2)
                            
                            Text(style.referenceLineStyle.formatter.format(value: plot.renderData[index].yValue))
                                .font(style.referenceLineStyle.xAxisLabelFont)
                                .foregroundColor(Color.white)
                                .shadow(radius: 2)
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
