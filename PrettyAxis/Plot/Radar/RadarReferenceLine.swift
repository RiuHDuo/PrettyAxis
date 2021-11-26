//
//  RadarReferenceView.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/25.
//

import SwiftUI


struct RadarReferenceLine: Shape{
    var sides: Int
    var rounded = false
    
    func path(in rect: CGRect) -> Path {
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0
        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        var path = Path()
        if rounded == true {
            path.addEllipse(in: CGRect(x: c.x - h, y: c.y - h, width: h * 2, height: h * 2))
        }
        
        for i in 0 ... sides {
            let angle = (Double(i) * (360.0 / Double(sides))) * Double.pi / 180
            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
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
