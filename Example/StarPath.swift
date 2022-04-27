//
//  StarPath.swift
//  Example
//
//  Created by RiuHDuo on 2022/4/27.
//

import SwiftUI



extension Path{
   static var star: some View{
        Path{ bezierPath in
            bezierPath.move(to: CGPoint(x: 21.89, y: 8.21))
            bezierPath.addLine(to: CGPoint(x: 21.89, y: 8.23))
            bezierPath.addCurve(to: CGPoint(x: 20.21, y: 6.79), control1: CGPoint(x: 21.65, y: 7.47), control2: CGPoint(x: 21, y: 6.91))
            bezierPath.addLine(to: CGPoint(x: 15.17, y: 6.01))
            bezierPath.addLine(to: CGPoint(x: 12.93, y: 1.23))
            bezierPath.addLine(to: CGPoint(x: 12.92, y: 1.22))
            bezierPath.addCurve(to: CGPoint(x: 11.01, y: 0), control1: CGPoint(x: 12.58, y: 0.48), control2: CGPoint(x: 11.83, y: 0))
            bezierPath.addLine(to: CGPoint(x: 11, y: 0))
            bezierPath.addCurve(to: CGPoint(x: 9.08, y: 1.22), control1: CGPoint(x: 10.17, y: 0), control2: CGPoint(x: 9.42, y: 0.48))
            bezierPath.addLine(to: CGPoint(x: 6.83, y: 6.01))
            bezierPath.addLine(to: CGPoint(x: 1.81, y: 6.78))
            bezierPath.addLine(to: CGPoint(x: 1.83, y: 6.78))
            bezierPath.addCurve(to: CGPoint(x: 0.12, y: 8.19), control1: CGPoint(x: 1.04, y: 6.89), control2: CGPoint(x: 0.38, y: 7.44))
            bezierPath.addLine(to: CGPoint(x: 0.12, y: 8.2))
            bezierPath.addCurve(to: CGPoint(x: 0.59, y: 10.36), control1: CGPoint(x: -0.14, y: 8.95), control2: CGPoint(x: 0.04, y: 9.79))
            bezierPath.addLine(to: CGPoint(x: 4.3, y: 14.17))
            bezierPath.addLine(to: CGPoint(x: 3.43, y: 19.52))
            bezierPath.addLine(to: CGPoint(x: 3.43, y: 19.53))
            bezierPath.addCurve(to: CGPoint(x: 5.2, y: 21.97), control1: CGPoint(x: 3.24, y: 20.69), control2: CGPoint(x: 4.04, y: 21.79))
            bezierPath.addCurve(to: CGPoint(x: 6.56, y: 21.73), control1: CGPoint(x: 5.67, y: 22.04), control2: CGPoint(x: 6.15, y: 21.96))
            bezierPath.addLine(to: CGPoint(x: 11, y: 19.27))
            bezierPath.addLine(to: CGPoint(x: 15.44, y: 21.73))
            bezierPath.addLine(to: CGPoint(x: 15.44, y: 21.73))
            bezierPath.addCurve(to: CGPoint(x: 18.33, y: 20.9), control1: CGPoint(x: 16.47, y: 22.3), control2: CGPoint(x: 17.76, y: 21.93))
            bezierPath.addCurve(to: CGPoint(x: 18.57, y: 19.53), control1: CGPoint(x: 18.56, y: 20.49), control2: CGPoint(x: 18.65, y: 20))
            bezierPath.addLine(to: CGPoint(x: 17.7, y: 14.17))
            bezierPath.addLine(to: CGPoint(x: 21.39, y: 10.38))
            bezierPath.addCurve(to: CGPoint(x: 21.89, y: 8.21), control1: CGPoint(x: 21.95, y: 9.8), control2: CGPoint(x: 22.14, y: 8.97))
            bezierPath.closeSubpath()
        }
        .frame(width: 24, height: 24)
        .foregroundColor(.red)
    }
}
