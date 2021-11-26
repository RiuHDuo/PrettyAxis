//
//  RadarShap.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/25.
//

import SwiftUI


struct RadarShape: Shape{
    var renderData: [AxisData]
    var range: (min: Double, max: Double)
    var animatableData: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let h = min(rect.size.width, rect.size.height) / 2
        var path = Path()
        var i = 0
        let range = self.range.max - self.range.min
        let unit = h / range
        let offset: CGFloat = self.range.min
        let x = rect.size.width / 2
        let y = rect.size.height / 2
        let angle = 360.0 / Double(renderData.count)
        renderData.forEach { data in
            let angle = (Double(i) * angle) * Double.pi / 180 - Double.pi / 2
            let p = (data.yValue - offset) * unit * animatableData
            let pt = CGPoint(x: x + CGFloat(cos(angle) * p), y: y + CGFloat(sin(angle) * p))
            if i == 0 {
                path.move(to: pt)
            } else {
                path.addLine(to: pt)
            }
            i += 1
        }
        path.closeSubpath()
        
        return path
    }
    
    
}
