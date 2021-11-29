//
//  ScrollableModifier.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/11/24.
//

import SwiftUI


struct ScrollableModifier<S: ChartStyle>: ViewModifier{
    
    var plot: Plot
    var style: S
    
    func body(content: Content) -> some View {
        let range = ((style.fromZero ? 0:  plot.range.min), plot.range.max)
        ScrollView(.horizontal, showsIndicators: false) {
            VStack {
                ZStack{
                    if style.showReferenceLine{
                        ReferenceLineView(range: range, style: self.style.referenceLineStyle)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    content
                        .padding(.leading, 20)
                }
                
                HStack(spacing: 0){
                    ForEach(plot.xAxisLabels, id: \.self){ data in
                        Text(data)
                            .font(self.style.labelStyle.labelFont)
                            .foregroundColor(self.style.labelStyle.labelColor)
                            .frame(width: style.labelWidth, height: self.style.labelStyle.labelHeight, alignment: .center)
                    }
                }
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            }

        }
    }
    
}
