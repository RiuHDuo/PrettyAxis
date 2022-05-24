//
//  RadarReferenceLine.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/5/17.
//

import Foundation
import SwiftUI


struct RadarReferenceLine: View{
    var labels: [String]
    var rounded = true
    var style: ReferenceLineStyle
    var range: (min: Double, max: Double)
    
    var body: some View{
        Canvas{ ctx, size in
            let txt = Text(self.labels.first ?? " ").font(self.style.xAxisLabelFont)
            let text = ctx.resolve(txt)
            let s = text.measure(in: CGSize(width: .infinity, height: CGFloat.infinity))
            let padding: CGFloat = 4
            
            let rect = CGRect(x: s.height + padding, y: s.height + padding, width: size.width - s.height * 2  - padding * 2, height: size.height - s.height * 2  - padding * 2)
            ctx.stroke(self.path(in: rect, sides: labels.count, scale: 1), with: style.axesColor)
            ctx.stroke(self.path(in: rect, sides: labels.count, scale: 1/3), with: style.axesColor, style: StrokeStyle(dash: [10]))
            ctx.stroke(self.path(in: rect, sides: labels.count, scale: 2/3), with: style.axesColor, style: StrokeStyle(dash: [10]))
            
            let c = CGPoint(x: size.width / 2.0, y: size.height / 2.0)
            let h = Double(min(size.width, size.height)) / 2.0
            if !style.hideXAxisLabel {
                for i in 0 ..< self.labels.count {
                    let text = self.labels[i]
                    let angle = Double.pi * 2 * (Double(i)) / Double(self.labels.count)
                    let pt = CGPoint(x: c.x + CGFloat(sin(angle) * h), y: c.y - CGFloat(cos(angle) * h))
                    let t = ctx.transform
                    ctx.transform = ctx.transform.translatedBy(x: pt.x, y: pt.y).rotated(by: angle)
                    let txt = Text(text).font(self.style.xAxisLabelFont).foregroundColor(self.style.xAxisLabelColor)
                    let tt = ctx.resolve(txt)
                    ctx.draw(tt, at: CGPoint.zero, anchor: .top)
                    ctx.transform = t
                }
            }
            
            if !style.hideYAxisLabel{
                let total = self.range.max - self.range.min
                for i in 0 ... 3{
                    let txt = Text(self.style.valueFormatter.format(value: total * Double(i) / 3)).font(self.style.yAxisLabelFont).foregroundColor(self.style.yAxisLabelColor)
                    let text = ctx.resolve(txt)
                    let t = ctx.transform
                    let angle = Double.pi / Double(labels.count)
                    ctx.transform = ctx.transform.translatedBy(x:  c.x, y: c.y).rotated(by: angle)
                    if rounded {
                        ctx.draw(text, at: CGPoint(x: 0, y: 0 - (rect.height / 2) * CGFloat(i) / 3.0), anchor: .center)
                    }else{
                        let y = (rect.height / 2) * CGFloat(i) / 3.0 * cos(angle)
                        ctx.draw(text, at: CGPoint(x: 0, y: -y), anchor: .bottom)
                    }
                    ctx.transform = t
                }
            }
        }
        
    }
    
    func path(in  rect: CGRect, sides: Int, scale: CGFloat) -> Path {
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0 * scale
        let c = CGPoint(x: rect.midX, y: rect.midY)
        var path = Path()
        if rounded == true {
            path.addEllipse(in: CGRect(x: c.x - h, y: c.y - h, width: h * 2, height: h * 2))
        }
        for i in 0 ... sides {
            let angle = Double.pi * 2 * (Double(i)) / Double(sides)
            let pt = CGPoint(x: c.x + CGFloat(sin(angle) * h), y: c.y - CGFloat(cos(angle) * h))
            if rounded {
                path.move(to: c)
                path.addLine(to: pt)
            }else {
                if i == 0 {
                    path.move(to: pt)
                } else {
                    path.addLine(to: pt)
                    path.addLine(to: c)
                    path.move(to: pt)
                }
            }
        }
        path.closeSubpath()
        return path
    }
}
