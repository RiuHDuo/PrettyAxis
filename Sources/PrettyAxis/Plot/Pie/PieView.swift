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
        let padding: CGFloat = style.enableOuterReferenceLine ? 20 : 0
        return GeometryReader{ reader in
            let r = min(reader.size.width, reader.size.height) / 2  - padding
            ZStack{
                ForEach(angles.indices){ index in
                    let ang2 = angles[index]
                    if let fill = style.fill[self.plot.xAxisLabels[index]]{
                        DoughnutSlice(radius: r, innerRadius: r * style.innerRadiusPercent, startAngle: .degrees(ang2.0), endAngle: .degrees(ang2.1))
                            .fill(fill)
                    }
                    
                    if style.showReferenceLine{
                        let angle = Angle(degrees: (ang2.0 + ang2.1) / 2)
                        referenceView(text: plot.xAxisLabels[index], percent: style.referenceLineStyle.formatter.format(value: plot.renderData[index].yValue))
                            .offset(x: r * (style.innerRadiusPercent / 2 +  0.5) * cos(angle.radians), y: r * (style.innerRadiusPercent / 2 +  0.5) * sin(angle.radians))
                    }
                    
                    DoughnutSlice(radius: r, innerRadius: r * style.innerRadiusPercent, startAngle: .degrees(ang2.0), endAngle: .degrees(ang2.1))
                        .stroke(style.color, lineWidth: style.lineWidth)
                }
                .padding(padding)
                outerReferenceView(radius: r)
            }
        }
    }
    
    var content: some View {
        let padding: CGFloat = style.enableOuterReferenceLine ? 20 : 0
        return GeometryReader{ reader in
            let r = min(reader.size.width, reader.size.height) / 2  - padding
            ZStack{
                ForEach(angles.indices){ index in
                    let ang2 = angles[index]
                    if let fill = style.fill[self.plot.xAxisLabels[index]]{
                        PieSlice(radius: r, startAngle: .degrees(ang2.0), endAngle: .degrees(ang2.1))
                            .fill(fill)
                    }
                    
                    if style.showReferenceLine{
                        let angle = Angle(degrees: (ang2.0 + ang2.1) / 2)
                        referenceView(text: plot.xAxisLabels[index], percent: style.referenceLineStyle.formatter.format(value: plot.renderData[index].yValue))
                            .offset(x: r * 0.6 * cos(angle.radians), y: r * 0.6 * sin(angle.radians))
                    }
                    
                    PieSlice(radius: r, startAngle: .degrees(ang2.0), endAngle: .degrees(ang2.1))
                        .stroke(style.color, lineWidth: style.lineWidth)
                }
                .padding(padding)
                outerReferenceView(radius: r)
            }
        }
    }
    
    
    @ViewBuilder
    func referenceView(text: String, percent: String) -> some View {
        VStack {
            Text(text)
                .font(style.referenceLineStyle.xAxisLabelFont)
                .foregroundColor(style.referenceLineStyle.axisLabelColor)
            
            Text(percent)
                .font(style.referenceLineStyle.xAxisLabelFont)
                .foregroundColor(style.referenceLineStyle.axisLabelColor)
        }
    }
    
    @ViewBuilder
    func outerReferenceView(radius: CGFloat) -> some View{
        Canvas{ ctx, size in
            let r = min(size.width, size.height) / 2
            let center = CGPoint(x: size.width / 2, y: size.height / 2)
            angles.indices.forEach{ index in
                let ang2 = angles[index]
                let angle = Angle(degrees: (ang2.0  + ang2.1) / 2)
                var point = CGPoint(x: center.x + CGFloat(cos(angle.radians)) * r, y:  center.y + CGFloat(sin(angle.radians)) * r)
                let p1 = CGPoint(x: center.x + CGFloat(cos(angle.radians)) * radius, y:  center.y + CGFloat(sin(angle.radians)) * radius)
                let text = Text( plot.xAxisLabels[index] + " " + style.referenceLineStyle.formatter.format(value: plot.renderData[index].yValue))
                    .font(style.referenceLineStyle.xAxisLabelFont)
                    .foregroundColor(style.referenceLineStyle.axisLabelColor)
                let txt = ctx.resolve(text)
                let s = txt.measure(in: CGSize(width: 100, height: CGFloat.infinity))
                let y = (point.y - s.height) / 2
                if y < 0 {
                    ctx.draw(text, at: CGPoint(x: point.x  + (point.x > center.x ? 4 : -4) , y: 0), anchor: point.x > center.x ? .topLeading: .topTrailing)
                    point = CGPoint(x: point.x, y:  s.height / 2)
                }else if y > size.height {
                    ctx.draw(text, at: CGPoint(x: point.x  + (point.x > center.x ? 4 : -4) , y: size.height - s.height), anchor: point.x > center.x ? .leading: .trailing)
                    point = CGPoint(x: point.x, y:  size.height - s.height / 2)
                }else{
                    ctx.draw(text, at: CGPoint(x: point.x  + (point.x > center.x ? 4 : -4) , y: point.y), anchor: point.x > center.x ? .leading: .trailing)
                }
                
                let path = Path{ p in
                    p.move(to: p1)
                    p.addLine(to: point)
                }
                ctx.stroke(path, with: .style(style.referenceLineStyle.axisColor), lineWidth: style.referenceLineStyle.axisWidth)
            }
        }
    }
}
