//
//  ReferenceLineYAxisView.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2021/12/9.
//

import SwiftUI

struct ReferenceLineYAxisView: View {
    var range: (min: Double, max: Double)
    var style: ReferenceLineStyle
    
    var body: some View {
        let values = [range.max, (range.max - range.min) / 3 * 2, (range.max - range.min) / 3, range.min]
        VStack{
            ForEach(values.indices){ index in
                Spacer()
                Text(style.formatter.format(value: values[index]))
                    .font(style.yAxisLabelFont)
                    .foregroundColor(style.axisLabelColor)
            }
        }
    }
}
