//
//  ReferenceLine.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/15.
//

import SwiftUI

struct ReferenceLineView<YAxis>: View where YAxis: View{
    var style: ReferenceLineStyle
    var yAxis: YAxis
    
    var body: some View{
        GeometryReader { reader in
            let size = reader.size
            let padding: CGFloat = 0
            HStack(spacing: 0) {
                VStack{
                    yAxis
                }.frame(width: 20)
                ZStack(alignment: .bottomLeading) {
                    ZStack {
                        line(from: CGPoint(x: 0, y: padding), to: CGPoint(x: 0, y: padding + size.height),  style: StrokeStyle(lineWidth: style.axisWidth))
                        line(from: CGPoint(x: 0, y: padding + size.height), to: CGPoint(x: size.width, y: padding + size.height),  style: StrokeStyle(lineWidth: style.axisWidth))
                        line(from: CGPoint(x: 0, y: padding + size.height / 3 ), to: CGPoint(x: size.width, y: padding + size.height / 3), style: StrokeStyle(lineWidth: style.axisWidth, lineCap: .round, lineJoin: .round, dash: [10.0]))
                        line(from: CGPoint(x: 0, y: padding + size.height / 3 * 2), to: CGPoint(x: size.width, y: padding + size.height / 3 * 2), style: StrokeStyle(lineWidth: style.axisWidth, lineCap: .round, lineJoin: .round, dash: [10.0]))
                    }
                    .frame(width: size.width, height: size.height + padding, alignment: .bottomLeading)
                    
                }

            }
        }
    }
    
    private func line(from: CGPoint, to: CGPoint, style: StrokeStyle = StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round)) -> some View{
        Path{ p in
            p.move(to: from)
            p.addLine(to: to)
        }
        .stroke(self.style.axisColor, style: style)
    }
    
}

