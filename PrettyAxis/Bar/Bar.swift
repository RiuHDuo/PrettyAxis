//
//  Bar.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/28.
//

import SwiftUI

struct Bar: View{
    
    var range: (min: Double, max: Double)
    var data: [(name: String, values: [Double], style: AxisPaintStyle)]
    var barWidth: CGFloat = 20
    var style: BarStyle
    
    var animatableData: CGFloat
    var date = Date()
    
    
    @State var value:Bool = false
    
    var body: some View{
        GeometryReader{ r in
            let unit = r.size.height / (range.max - range.min)
            let xAxisStart = CGFloat(self.style.xAxisAtValue ?? range.min)
            let xAxisPos = r.size.height  - unit * (xAxisStart - range.min)
            ForEach(self.data.indices, id: \.self){ index in
                let item = self.data[index]
                ForEach(item.values.indices, id: \.self){ idx in
                    let value = item.values[idx]
                    bar(value: CGFloat(value), unit: unit, xAxisStart: xAxisStart, xAxisPos: xAxisPos, offset: (barWidth * CGFloat(data.count) + style.spacing) * CGFloat(idx) + barWidth * CGFloat(index), style: item.style)
                }
            }
        }
    }
    
    var contentView: some View{
        let dates: [Date] = (0 ..< 60).map({date.addingTimeInterval(Double($0) * 0.017)})
        return TimelineView(.explicit(dates)) { timeline in
            canvas(date: timeline.date)
        }
    }
    
    func canvas(date: Date) -> some View {
        Canvas{ ctx, size in
            let h = date.timeIntervalSince(self.date)
            let size = CGSize(width: size.width, height: size.height)
            let xAxisStart = CGFloat(self.style.xAxisAtValue ?? range.min)
            let unit = size.height / (range.max - range.min)
            let xAxisPos = size.height  - unit * (xAxisStart - range.min)
            var offset: CGFloat = 0
            data.forEach { item in
                var offset2: CGFloat = 0
                item.values.forEach { value in
                    let h = unit * (CGFloat(value - xAxisStart)) * h
                    var y = xAxisPos
                    if h > 0{
                        y = xAxisPos - h
                    }
                    let rect = CGRect(x: offset + offset2, y: y, width: barWidth, height: abs(h))
                    ctx.stroke(Path(roundedRect: rect, cornerSize: CGSize(width: 8, height: 8)), with: .style(item.style.stroke))
                    if let fill = item.style.fill {
                        ctx.fill(Path(roundedRect: rect, cornerSize: CGSize(width: 8, height: 8)), with: .style(fill))
                    }
                    
                    if !self.style.hideValueLabel {
                        let txt = Text(self.style.valueFormatter.format(value: value))
                            .font(self.style.valueLabelFont)
                            .foregroundColor(self.style.valueLabelColor)
                        let text = ctx.resolve(txt)
                        let s = text.measure(in: CGSize(width: barWidth, height: CGFloat.infinity))
                        if value < xAxisStart {
                            ctx.draw(text, in: CGRect(origin: CGPoint(x: rect.midX - s.width / 2, y: rect.maxY + 4), size: CGSize(width: s.width, height: s.height)))
                        }else{
                            ctx.draw(text, in: CGRect(origin:CGPoint(x: rect.midX - s.width / 2, y: rect.minY - 4 - s.height), size: CGSize(width: s.width, height: s.height)))
                        }
                    }
                    offset2 += barWidth * CGFloat(data.count) + style.spacing
                }
                offset += barWidth
            }
        }
    }
    
    func bar(value: CGFloat, unit: CGFloat, xAxisStart: CGFloat, xAxisPos: CGFloat, offset: CGFloat, style: AxisPaintStyle) -> some View{
        let h = unit * (CGFloat(value - xAxisStart)) * animatableData
        var y = xAxisPos
        if h > 0{
            y = xAxisPos - h
        }
        let txt = Text(self.style.valueFormatter.format(value: value))
            .font(self.style.valueLabelFont)
            .foregroundColor(self.style.valueLabelColor)
            .frame(width: barWidth)
        return RoundedRectangle(cornerRadius: self.style.barRadius)
            .fill(style.fill ?? style.stroke)
            .frame(width: barWidth, height: max(abs(h), 1))
            .overlay(alignment: value > xAxisStart ? .bottom : .top, content: {
                VStack(spacing: 0){
                    if value > xAxisStart {
                        txt
                    }
                    Spacer()
                        .frame(height: abs(h))
                    if value <= xAxisStart {
                        txt
                    }
                }
            })
            .offset(x: offset, y: y)
        
    }
}
