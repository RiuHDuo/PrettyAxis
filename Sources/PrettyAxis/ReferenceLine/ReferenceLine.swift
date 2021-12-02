//
//  ReferenceLine.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/19.
//

import SwiftUI

enum ReferenceLineType{
    case horizontal
    case vertical
    case axis
}

struct ReferenceLine: Shape{
    let type: ReferenceLineType
    
    func path(in rect: CGRect) -> Path {
        return Path{ p in
            p.move(to: CGPoint.zero)
            switch type {
            case .horizontal:
                p.addLine(to: CGPoint(x: 0, y: rect.height))
            case .vertical:
                p.addLine(to: CGPoint(x: rect.width, y: 0))
            case .axis:
                p.addLine(to: CGPoint(x: 0, y: rect.height))
            }
        }
    }
    
}
