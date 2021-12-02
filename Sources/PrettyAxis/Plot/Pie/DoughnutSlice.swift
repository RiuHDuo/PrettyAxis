//
//  DoughnutSlice.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/30.
//

import Foundation
import SwiftUI


struct DoughnutSlice: Shape{
    var radius: CGFloat
    var innerRadius: CGFloat
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let p2 = CGPoint(x: rect.midX + CGFloat(cos(startAngle.radians)) * innerRadius, y:  rect.midY + CGFloat(sin(startAngle.radians)) * innerRadius)
        path.move(to: p2)
        
        let p1 = CGPoint(x: rect.midX + CGFloat(cos(startAngle.radians)) * radius, y:  rect.midY + CGFloat(sin(startAngle.radians)) * radius)
        path.addLine(to: p1)

        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        let p3 = CGPoint(x: rect.midX + CGFloat(cos(endAngle.radians)) * innerRadius, y:  rect.midY + CGFloat(sin(endAngle.radians)) * innerRadius)
        path.addLine(to: p3)
        
        
        path.addArc(center: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: true)
        


        path.closeSubpath()

        return path
    }
}
