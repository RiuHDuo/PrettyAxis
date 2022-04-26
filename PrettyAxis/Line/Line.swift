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
    var points: [(x: String, y: Double)]
    var range: (min: Double, max: Double)
    var lineType: LineType
    var isFilled: Bool
    var spacing: CGFloat
    var animatableData: CGFloat
    
    func path(in rect: CGRect) -> Path {
        guard points.count > 1 else{
            return Path()
        }
        let unit = rect.height / (range.max - range.min)
        let pp = self.points
        
        let spacing = self.spacing
        var points = (0 ..< pp.count).map({ i -> CGPoint in
            let axisData = pp[i]
            return CGPoint(x:CGFloat(i) * spacing, y: rect.size.height - (axisData.y -  CGFloat(range.min)) * unit)
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
                let x = points.last?.x
                p.addLine(to: CGPoint(x: x!, y: rect.height))
                p.addLine(to: CGPoint(x: 0, y: rect.height))
                p.addLine(to: points.first!)
            }
        }
        .trimmedPath(from: 0, to: self.animatableData)
    }
}


