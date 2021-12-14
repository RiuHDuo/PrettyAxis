//
//  LineMark.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/22.
//

import SwiftUI

struct LineMark:Shape{
    var points: [AxisData<String, Double, AnyHashable>]
    var range: (min: Double, max: Double)
    var spacing: CGFloat
    var animatableData: CGFloat
    var lineType: LineType
    var isFilled: Bool = false
    var mark: Path
    
    
    func path(in rect: CGRect) -> Path {
        guard points.count > 1 else{
            return Path()
        }
        let unit = rect.height / (range.max - range.min)
        let points = (0 ..< self.points.count).map({ i -> CGPoint in
            let axisData = self.points[i]
            return CGPoint(x:CGFloat(i) * spacing + spacing / 2, y: rect.size.height - (axisData.yValue - CGFloat(range.min)) * unit * animatableData)
        })
        
        return Path{ p in
            points.forEach({p.addPath(mark, transform: CGAffineTransform(translationX: $0.x, y: $0.y))})
            
        }
    }
}
