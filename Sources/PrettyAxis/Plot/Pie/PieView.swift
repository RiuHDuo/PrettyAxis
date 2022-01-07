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
    
    @State var animated = false
    var body: some View {
        if style.disableLegend {
            content
        }else{
            content.modifier(LegendModifier(list: plot.xAxisLabels.map({($0, style.fill[$0] ?? DEFAULT_COLOR)}), style: style.legendStyle))
        }
    }
    
    private var angles: [(Double, Double)] {
        var angles:[ (Double, Double)] = []
        var angle: Double = 0
        self.plot.renderData.forEach { item in
            let end = item.yValue * 360 + angle
            angles.append((angle, end))
            angle = end
        }
        return angles
    }
    
    var content: some View{
        let padding: CGFloat = style.enableOuterReferenceLine ? 20 : 0
        return GeometryReader{ reader in
            let r = min(reader.size.width, reader.size.height) / 2  - padding
            let center = CGPoint(x: reader.size.width / 2, y: reader.size.height / 2)

            ZStack{
                ForEach(angles.indices){ index in
                    let ang2 = angles[index]
                    if let fill = style.fill[self.plot.xAxisLabels[index]]{
                        if style.innerRadiusPercent < 1 {
                            DoughnutSlice(radius: r, innerRadius: r * style.innerRadiusPercent, startAngle: .degrees(ang2.0), endAngle: .degrees(ang2.1))
                                .fill(fill)
                        }else{
                            PieSlice(radius: r, startAngle: .degrees(ang2.0), endAngle: .degrees(ang2.1))
                                .fill(fill)
                        }
                    }

                    if style.showReferenceLine{
                        let angle = Angle(degrees: (ang2.0 + ang2.1) / 2)
                        if style.innerRadiusPercent < 1 {
                            referenceView(text: plot.xAxisLabels[index], percent: style.referenceLineStyle.formatter.format(value: plot.renderData[index].yValue))
                                .offset(x: r * (style.innerRadiusPercent / 2 +  0.5) * cos(angle.radians), y: r * (style.innerRadiusPercent / 2 +  0.5) * sin(angle.radians))
                        }else{
                            referenceView(text: plot.xAxisLabels[index], percent: style.referenceLineStyle.formatter.format(value: plot.renderData[index].yValue))
                                .offset(x: r * 0.6 * cos(angle.radians), y: r * 0.6 * sin(angle.radians))
                        }
                    }
                    if style.innerRadiusPercent < 1 {
                        DoughnutSlice(radius: r, innerRadius: r * style.innerRadiusPercent, startAngle: .degrees(ang2.0), endAngle: .degrees(ang2.1))
                            .stroke(style.color, lineWidth: style.lineWidth)
                    }else{
                        PieSlice(radius: r, startAngle: .degrees(ang2.0), endAngle: .degrees(ang2.1))
                            .stroke(style.color, lineWidth: style.lineWidth)
                    }
                }
                .padding(padding)
                if self.style.enableOuterReferenceLine {
                    outerReferenceView(radius: r)
                }
            }
            .clipShape(PieSlice(radius: r, startAngle: .degrees(0), endAngle: .degrees(animated ? 360: 0)))
        }
        .onAppear(){
            withAnimation {
                animated.toggle()
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
