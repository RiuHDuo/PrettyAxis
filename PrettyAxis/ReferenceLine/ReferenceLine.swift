//
//  ReferenceLine.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/26.
//

import SwiftUI



struct ReferenceLine: View{
    var labels: [String]
    var spacing: CGFloat?
    var range:(min: Double, max: Double)
    var style: ReferenceLineStyle
    var xAxisStartValue: Double?
    
    var body: some View{
        Canvas{ ctx, size  in
            let height = size.height - self.style.bottomPadding
            if !self.style.hideReferenceLine {
                /// Draw Reference Line
                for i in [0, 0.25, 0.5, 0.75, 1] {
                    ctx.stroke(line(from: CGPoint(x: self.style.leadingPadding , y: height * CGFloat(i)), to: CGPoint(x: size.width, y: height *  CGFloat(i))), with: .color(.gray), style: StrokeStyle(lineWidth: self.style.dashLineWidth, lineCap: .round, lineJoin: .round, dash: [self.style.dashLineLength]))
                }
            }
            if !self.style.hideXAxisLabel {
                /// Draw X-Axis
                
                let xAxisStartValue = self.xAxisStartValue ?? 0
                let unit = height /  CGFloat(range.max - range.min)
                let h = height - abs(xAxisStartValue - range.min) * unit
                ctx.stroke(line(from: CGPoint(x: self.style.leadingPadding  , y: h), to: CGPoint(x: size.width, y: h)), with: .color(.gray), style: StrokeStyle(lineWidth: self.style.xAxisLineWidth, lineCap: .round, lineJoin: .round))
                
                /// Draw X-Axis lables
                
                let spacing = self.spacing ?? (size.width - self.style.leadingPadding ) / CGFloat(labels.count - 1)
                var i: CGFloat  = 0
                labels.forEach { label in
                    let txt = Text(label).font(self.style.xAxisLabelFont).foregroundColor(self.style.xAxisLabelColor)
                    let text = ctx.resolve(txt)
                    let s = text.measure(in: CGSize(width: .infinity, height: CGFloat.infinity))
                    var x = spacing * i + self.style.leadingPadding
                    if i == 0 {
                        x +=  s.width / 2
                    }else if i == CGFloat(labels.count - 1) {
                        x -=  s.width / 2
                    }
                    ctx.draw(text, at: CGPoint(x: x, y: size.height - self.style.bottomPadding + s.height + 4))
                    i += 1
                }
            }
            
            
            if !self.style.hideYAxisLabel {
                /// Draw Y-Axis
                ///
                ctx.stroke(line(from: CGPoint(x: self.style.yAxisWidth + self.style.yAxisLineWidth / 2, y: 0), to: CGPoint(x: self.style.yAxisWidth + self.style.yAxisLineWidth / 2, y: height)), with: .color(.gray), style: StrokeStyle(lineWidth: self.style.yAxisLineWidth))
                let rr = range.max - range.min
                for i in [0, 0.25, 0.5, 0.75, 1] {
                    let value = range.max - rr * i
                    let txt = Text(self.style.valueFormatter.format(value: value)).font(self.style.yAxisLabelFont).foregroundColor(self.style.yAxisLabelColor)
                    let text = ctx.resolve(txt)
                    let s = text.measure(in: CGSize(width: .infinity, height: CGFloat.infinity))
                    if i == 0 {
                        ctx.draw(text, at: CGPoint(x: s.width / 2, y: height * CGFloat(i) + s.height / 2))
                    }else{
                        ctx.draw(text, at: CGPoint(x: s.width / 2, y: height * CGFloat(i)))
                    }
                }
            }
        }
    }
    
    
    
    private func line(from: CGPoint, to: CGPoint) -> Path{
        return Path{ p in
            p.move(to: from)
            p.addLine(to: to)
        }
    }
}
