//
//  Bar.swift
//  PrettyAxis
//
//  Created by RiuHDuo on 2022/4/28.
//

import SwiftUI

struct BarView: View{
    
    var range: (min: Double, max: Double)
    var data: [(name: String, values: [Double], style: AxisPaintStyle)]
    var barWidth: CGFloat = 20
    var style: BarStyle
    var date = Date()
    var onTapCallback: ((String, Int, Double) -> Void)?
    
    var body: some View{
        GeometryReader{ r in
            let unit = r.size.height / (range.max - range.min)
            let xAxisStart = CGFloat(self.style.xAxisAtValue ?? range.min)
            let xAxisPos = r.size.height  - unit * (xAxisStart - range.min)
            ForEach(self.data.indices, id: \.self){ index in
                let item = self.data[index]
                ForEach(item.values.indices, id: \.self){ idx in
                    let value = item.values[idx]
                    let offsetX =  (barWidth * CGFloat(data.count) + style.spacing) * CGFloat(idx) + barWidth * CGFloat(index) + CGFloat(index + idx) * style.groupSpacing
                    Bar(index: Double(idx), value: CGFloat(value), unit: unit, barWidth: barWidth, xAxisStart: xAxisStart, xAxisPos: xAxisPos, offset: offsetX, paintStyle: item.style, style: self.style, onTapCallback: {value in
                        self.onTapCallback?(item.name, idx, value)
                    })
                }
            }
        }
    }
}

