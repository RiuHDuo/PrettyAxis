//
//  Scatter.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/26.
//

import Foundation
import SwiftUI


struct ScatterShape: Shape{
    var renderData: [ScatterData]
    var yunit: CGFloat
    var xunit: CGFloat
    var zunit: CGFloat
    var radius: CGFloat
    var xOffset: CGFloat
    var yOffset: CGFloat
    
    func path(in rect: CGRect) -> Path {
        return Path{ p in
            p .move(to: CGPoint.zero)
            renderData.forEach { data in
                let point = CGPoint(x: (data.xValue - xOffset)  * xunit, y: rect.height - (data.yValue - yOffset)  * yunit)
                let r = radius
                p.addEllipse(in: CGRect(x: point.x - r / 2, y: point.y - r / 2, width: r, height: r))
            }
        }
    }
}
