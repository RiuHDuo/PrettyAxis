//
//  RadarReferenceLineModifier.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/5/24.
//

import SwiftUI


struct RadarReferenceLineModifier: ViewModifier{
    var labels: [String]
    var rounded = true
    var style: ReferenceLineStyle
    var range: (min: Double, max: Double)
    @State var padding: CGFloat = 0
    
    func body(content: Content) -> some View {
        ZStack{
            content
                .padding(.vertical, padding)
            RadarReferenceLine(labels: labels, rounded: rounded, style: style, range: range, padding: $padding)
        }
    }
}
