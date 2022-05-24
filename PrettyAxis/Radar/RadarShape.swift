//
//  RadarShap.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/5/18.
//

import SwiftUI

struct RadarShape: Shape{
    let values: [Double]
    let range: (CGFloat, CGFloat)
    var animatableData: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let x = rect.midX
        let y = rect.midY
        var i = 0
        let unit =  min(rect.size.height / 2, rect.size.width / 2) / (self.range.0 - self.range.1)
        let offset: CGFloat = 0
        let total = values.reduce(0, {$0 + $1}) * Double(animatableData)
        var count = 0.0
        values.forEach { data in
            let value = data
            var v = count + value < total ? value: total - count
            if v < range.0 {
                v = range.0
            }
            let angle = Double.pi * 2 * (Double(i)) / Double(values.count) - Double.pi
            let p = (v - offset - self.range.0) * unit
            let pt = CGPoint(x: x + CGFloat(sin(angle) * p), y: y - CGFloat(cos(angle) * p))
            if i == 0 {
                path.move(to: pt)
            } else {
                path.addLine(to: pt)
            }
            i += 1
            count += value
        }
        path.closeSubpath()
        return path
    }
}
