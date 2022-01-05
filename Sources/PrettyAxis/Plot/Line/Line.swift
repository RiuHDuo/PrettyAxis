//
//  Line.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/18.
//

import SwiftUI
import Foundation

public enum LineType{
    case smooth(curviness: CGFloat)
    case straight
    case step
}

struct Line: Shape {
    var points: [AxisData<String, Double, AnyHashable>]
    var range: (min: Double, max: Double)
    var spacing: CGFloat
    var animatableData: CGFloat
    var lineType: LineType
    var isFilled: Bool = false
    
    func path(in rect: CGRect) -> Path {
        guard points.count > 1 else{
            return Path()
        }
        let unit = rect.height / (range.max - range.min)
        var points = (0 ..< self.points.count).map({ i -> CGPoint in
            let axisData = self.points[i]
            return CGPoint(x:CGFloat(i) * spacing + spacing / 2, y: rect.size.height - (axisData.yValue -  CGFloat(range.min)) * unit * animatableData)
        })
        points.insert(CGPoint(x: 0, y: points.first?.y ?? 0), at: 0)
        
        return Path { p in
            p.move(to: CGPoint(x: points.first?.x ?? 0, y: points.first?.y ?? 0))
            switch self.lineType{
            case .straight:
                points.forEach { point in
                    p.addLine(to: point)
                }
            case .smooth(let lineCurviness):
                if points.count > 0 {
                    for i in 1 ..< points.count {
                        let current = points[i]
                        let previous = points[i - 1]
                        let difference = current.x - previous.x
                        p.addCurve(to: current, control1: CGPoint(x: previous.x + (difference * lineCurviness), y:  previous.y), control2: CGPoint(x: current.x - (difference * lineCurviness), y:  current.y))
                    }
                }
            case .step:
                if points.count > 0 {
                    for i in 1 ..< points.count {
                        let current = points[i]
                        let previous = points[i - 1]
                        p.addLine(to: CGPoint(x: previous.x, y: current.y))
                        p.addLine(to: CGPoint(x: current.x, y: current.y))
                    }
                }
            }
            
            if isFilled {
                p.addLine(to: CGPoint(x: points.last!.x, y: rect.height))
                p.addLine(to: CGPoint(x: 0, y: rect.height))
                p.closeSubpath()
            }
        }
    }
}

extension Line{
    func fillRect<S>(_ s: S) -> some View where S : ShapeStyle{
        var copy = self
        copy.isFilled = true
        return copy.fill(s)
    }
}
