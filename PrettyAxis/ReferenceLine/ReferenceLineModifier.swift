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
    
    let paddingBottom: CGFloat = 32
    let paddingLeading: CGFloat = 48
    
    
    func body(content: Content) -> some View{
        ZStack{
            if isHidden == false{
                ReferenceLine(labels: self.labels, spacing: self.spacing, range: range, style: style)
            }
            content
                .padding(.leading, self.style.leadingPadding)
                .padding(.bottom, self.style.xAxisHeight)
        }
    }
}
