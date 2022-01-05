//
//  LineValue.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/1/5.
//

import SwiftUI

struct LineValue: View{
    let data: [AxisData<String, Double, AnyHashable>]
    let range: (min: Double, max: Double)
    let spacing: CGFloat
    let valueOffset: CGPoint
    let font: Font
    var body: some View{
        Canvas{ ctx, size in
           let unit = size.height / (range.max - range.min)
           var index = 0
           data.forEach { axis in
               let text = IntFormatter().format(value: axis.yValue)
               let txt = ctx.resolve(Text(text).font(font))
               let s = txt.measure(in: CGSize(width: spacing, height: .infinity))
               let h: CGFloat = s.height
               let y = size.height -  (axis.yValue - CGFloat(range.min)) * unit - h
               ctx.draw(txt, in: CGRect(x: CGFloat(index) * spacing + (spacing - s.width) / 2 + valueOffset.x, y: y + valueOffset.y, width: s.width, height: h))
               index += 1
           }
        }
    }
}
