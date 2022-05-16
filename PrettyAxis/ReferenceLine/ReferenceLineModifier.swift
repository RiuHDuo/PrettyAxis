//
//  ReferenceLineModifier.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/26.
//

import SwiftUI


struct ReferenceLineModifier: ViewModifier{
    var isHidden: Bool
    var labels: [String]
    var spacing: CGFloat?
    var range:(min: Double, max: Double)
    var style: ReferenceLineStyle
    var xAxisStartValue: Double?
    var labelOffset: CGPoint = .zero
    
    
    func body(content: Content) -> some View{
        ZStack{
            if isHidden == false{
                ReferenceLine(labels: self.labels, spacing: self.spacing, range: range, style: style, xAxisStartValue: xAxisStartValue, labelOffset: labelOffset)
            }
            content
                .padding(.leading, isHidden ? 0: self.style.leadingPadding)
                .padding(.bottom, isHidden ? 0: self.style.bottomPadding)
        }
    }
}
